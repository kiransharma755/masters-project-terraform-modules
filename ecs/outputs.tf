output "ecs_cluster" {
  value = "${aws_ecs_cluster.main.id}"
}

output "ecs_security_group" {
  value = "${aws_security_group.ecs.id}"
}
