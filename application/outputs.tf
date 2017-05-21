output "elb_fqdn" {
  value = "${aws_elb.service_elb.dns_name}"
}

output "elb_security_group" {
  value = "${aws_security_group.service_elb.id}"
}
