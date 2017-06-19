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
  db_subnet_group_name   = "${var.db_subnet_group_name}"
  parameter_group_name   = "${var.parameter_group_name}"
  vpc_security_group_ids = "RDS security ID"
}

resource "aws_db_subnet_group" "rds" {
  name = "${var.name}"
  subnet_ids = "${var.subnets}"
}

resource "aws_security_group" "rds" {
  name = "${var.name}-${var.env}-rds"
  description = "Security group for RDS instance ${var.name}-${var.env}"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "allow_rds_out" {
  security_group_id = "${aws_security_group.rds.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_route53_record" "rds" {
  zone_id = "${var.zone_id}"
  name = "${var.name}-${var.env}-rds"
  type = "CNAME"
  ttl = "${var.ttl}"
}

