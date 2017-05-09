resource "aws_security_group" "ecs" {
  name        = "${var.name}-ecs-${var.env}"
  description = "Security group for ECS instances"
  vpc_id      = "${var.vpc}"
}

resource "aws_security_group_rule" "allow_ecs_out" {
  security_group_id = "${aws_security_group.ecs.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_ssh_in" {
  security_group_id = "${aws_security_group.ecs.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = "${var.allowed_hosts}"
}

resource "aws_ecs_cluster" "main" {
  name = "${var.name}-${var.env}"
}

resource "aws_iam_instance_profile" "ecs" {
  name  = "ecs-profile"
  roles = ["${aws_iam_role.ecs_ec2.name}"]
}

data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user_data.tpl")}"

  vars {
    ecs_cluster_name = "${aws_ecs_cluster.main.name}"
  }
}

resource "aws_launch_configuration" "ecs" {
  name                 = "ecs_cluster_config"
  instance_type        = "${var.instance_type}"
  image_id             = "${var.image_id}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
  security_groups      = ["${aws_security_group.ecs.id}"]
  user_data            = "${data.template_file.user_data.rendered}"
  key_name             = "${var.keypair_name}"
}

resource "aws_autoscaling_group" "ecs" {
  name                 = "${var.name}-${var.env}"
  vpc_zone_identifier  = ["${var.subnets}"]
  launch_configuration = "${aws_launch_configuration.ecs.name}"
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  desired_capacity     = "${var.desired_capacity}"
}
