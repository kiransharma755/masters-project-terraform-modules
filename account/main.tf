resource "aws_key_pair" "account" {
  key_name   = "${var.key_name}"
  public_key = "${var.pub_key_file}"
}
