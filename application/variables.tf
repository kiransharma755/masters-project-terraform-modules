variable "env" {
  description = "The environment"
}

variable "name" {
  description = "Name of the application"
}

variable "subnets" {
  description = "Subnet to launch ECS cluster instances in"
  type        = "list"
}

variable "security_groups" {
  description = "Security groups to attach to the application load balancer"
  type        = "list"
}

variable "instance_port" {
  description = "Application port on the instance"
}

variable "health_check_target" {
  description = "Target for the application's health check"
}

variable "container_definitions" {
  description = "Definitions for the service containers"
}

variable "container_port" {
  description = "Application port on the container"
}

variable "ecs_cluster" {
  description = "ECS cluster to put task into"
}
