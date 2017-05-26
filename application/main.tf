resource "aws_elb" "service_elb" {
  name                      = "${var.name}"
  subnets                   = ["${var.subnets}"]
  connection_draining       = true
  cross_zone_load_balancing = true
  security_groups           = ["${aws_security_group.service_elb.id}"]

  listener = {
    instance_port     = "${var.instance_port}"
    instance_protocol = "http"
    lb_port           = "80"
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 5
    target              = "HTTP:${var.instance_port}${var.health_check_target}"
    interval            = 5
    timeout             = 4
  }
}

resource "aws_security_group" "service_elb" {
  name        = "Service ELB"
  description = "Security group for ELB of ECS service"
  vpc_id      = "${var.vpc}"
}

resource "aws_security_group_rule" "allow_http_in" {
  type              = "ingress"
  to_port           = 80
  from_port         = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.service_elb.id}"
}

resource "aws_security_group_rule" "allow_all_out" {
  type              = "egress"
  to_port           = 0
  from_port         = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.service_elb.id}"
}

data "template_file" "task_definition" {
  template = "${file("${path.module}/files/ecs-task-definition.tpl")}"

  vars {
    name           = "${var.name}-${var.env}"
    image          = "${var.image}"
    cpu            = "${var.cpu_limit}"
    memory         = "${var.memory_limit}"
    container_port = "${var.container_port}"
    host_port      = "${var.instance_port}"
  }
}

resource "aws_ecs_task_definition" "service_task" {
  family                = "${var.name}"
  container_definitions = "${var.container_definitions}"
}

resource "aws_ecs_service" "service" {
  name            = "${var.name}-${var.env}"
  cluster         = "${var.ecs_cluster}"
  task_definition = "${aws_ecs_task_definition.service_task.arn}"
  desired_count   = 2
  iam_role        = "${aws_iam_role.ecs_elb.arn}"

  load_balancer {
    elb_name       = "${aws_elb.service_elb.id}"
    container_name = "${var.name}-${var.env}"
    container_port = "${var.container_port}"
  }
}

data "aws_iam_policy_document" "ecs_elb_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_elb" {
  name               = "${var.name}-${var.env}-ecs-elb"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_elb_assume_role.json}"
}

data "aws_iam_policy_document" "ecs_elb" {
  statement {
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RegisterTargets",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "ecs_elb" {
  name   = "${var.name}-${var.env}-ecs-elb-policy"
  role   = "${aws_iam_role.ecs_elb.id}"
  policy = "${data.aws_iam_policy_document.ecs_elb.json}"
}
