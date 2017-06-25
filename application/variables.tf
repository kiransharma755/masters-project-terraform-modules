variable "env" {
  description = "The environment"
}

variable "name" {
  description = "Name of the application"
}

variable "image" {
  description = "Docker image to deploy"
}

variable "cpu_limit" {
  description = "CPU limit for the ECS task"
  default     = 0
}

variable "memory_limit" {
  description = "Memory limit for the ECS task"
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

variable "container_port" {
  description = "Application port on the container"
}

variable "ecs_cluster" {
  description = "ECS cluster to put task into"
}

variable "env_vars" {
  description = "Container environment variables"
  type        = "map"
}
