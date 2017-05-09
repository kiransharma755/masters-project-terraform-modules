resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allows ssh from the world"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name = "bastion"
  }
}

resource "aws_security_group_rule" "allow_ssh_in" {
  security_group_id = "${aws_security_group.bastion.id}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = "${var.allowed_hosts}"
}

resource "aws_security_group_rule" "allow_ecs_out" {
  security_group_id = "${aws_security_group.bastion.id}"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

// Add our instance description
resource "aws_instance" "bastion" {
  ami               = "${var.ami}"
  source_dest_check = false
  instance_type     = "${var.instance_type}"
  subnet_id         = "${var.subnet_id}"
  key_name          = "${var.key_name}"
  security_groups   = ["${aws_security_group.bastion.id}"]

  tags {
    Name        = "bastion-01"
    Environment = "${var.env}"
  }
}

// Setup our elastic ip
resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  vpc      = true
}
