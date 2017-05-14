resource "aws_elb" "service_elb" {
  name                      = "${var.name}"
  subnets                   = "${var.subnets}"
  connection_draining       = true
  cross_zone_load_balancing = true
  security_groups           = "${var.security_groups}"

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

resource "aws_ecs_task_definition" "service_task" {
  family                = "${var.name}"
  container_definitions = "${var.container_definitions}"
}

resource "aws_ecs_service" "service" {
  name            = "${var.name}-${var.env}"
  cluster         = "${var.ecs_cluster}"
  task_definition = "${aws_ecs_task_definition.service_task.arn}"
  desired_count   = 2
  iam_role        = "${var.service_iam_role}"

  load_balancer {
    elb_name       = "${aws_elb.service_elb.id}"
    container_name = "${var.name}-${var.env}"
    container_port = "${var.container_port}"
  }
}
