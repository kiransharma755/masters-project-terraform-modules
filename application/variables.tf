variable "env" {
  description = "The environment"
}

variable "name" {
  description = "Name of the application"
}

variable "vpc" {
  description = "VPC for ELB security group"
}

variable "subnets" {
  description = "Subnet for ECS Service ELB"
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
