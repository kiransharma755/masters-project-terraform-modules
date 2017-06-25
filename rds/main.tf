resource "aws_db_instance" "default" {
  allocated_storage      = "${var.allocated_storage}"
  storage_type           = "${var.storage_type}"
  engine                 = "${var.engine}"
  engine_version         = "${var.engine_version}"
  instance_class         = "${var.instance_class}"
  publicly_accessible    = "${var.publicly_accessible}"
  name                   = "${var.name}-${var.env}"
  username               = "${var.username}"
  password               = "${var.password}"
  db_subnet_group_name   = "${aws_db_subnet_group.rds.name}"
  parameter_group_name   = "${var.parameter_group_name}"
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
}

resource "aws_db_subnet_group" "rds" {
  name       = "${var.name}"
  subnet_ids = ["${var.subnets}"]
}

resource "aws_security_group" "rds" {
  name        = "${var.name}-${var.env}-rds"
  description = "Security group for RDS instance ${var.name}-${var.env}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "allow_rds_out" {
  security_group_id = "${aws_security_group.rds.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_ecs_in" {
  security_group_id        = "${aws_security_group.rds.id}"
  type                     = "ingress"
  from_port                = "${var.port[var.engine]}"
  to_port                  = "${var.port[var.engine]}"
  protocol                 = "tcp"
  source_security_group_id = "${var.allowed_security_group_id}"
}

resource "aws_security_group_rule" "allow_bastion_in" {
  security_group_id = "${aws_security_group.rds.id}"
  type              = "ingress"
  from_port         = "${var.port[var.engine]}"
  to_port           = "${var.port[var.engine]}"
  protocol          = "tcp"
  cidr_blocks       = ["${var.bastion_ip}"]
}

resource "aws_route53_record" "rds" {
  zone_id = "${var.zone_id}"
  name    = "${var.name}-${var.env}-rds"
  type    = "CNAME"
  ttl     = "${var.ttl}"
}
