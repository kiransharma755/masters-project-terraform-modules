resource "aws_db_instance" "default" {
  allocated_storage    = "${var.allocated_storage}"
  storage_type         = "${var.storage_type}"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  instance_class       = "${var.instance_class}"
  publicly_accessible  = "${var.publicly_accessible}"
  name                 = "${var.name}"
  username             = "${var.username}"
  password             = "${var.password}"
  db_subnet_group_name = "${var.db_subnet_group_name}"
  parameter_group_name = "${var.parameter_group_name}"
}
