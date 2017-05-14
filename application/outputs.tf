output "elb_fqdn" {
  value = "${aws_elb.service_elb.dns_name}"
}
