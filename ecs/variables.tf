variable "env" {
  description = "The environment"
}

variable "name" {
  description = "Name of the ECS cluster"
}

variable "vpc" {
  description = "VPC for module"
}

variable "subnets" {
  description = "Subnet to launch ECS cluster instances in"
  type        = "list"
}

variable "allowed_hosts" {
  description = "Subnet to launch ECS cluster instances in"
  type        = "list"
}

variable "instance_type" {
  description = "Instance type for ECS cluster"
  default     = "t2.micro"
}

variable "image_id" {
  description = "ID of AMI for cluster EC2 machines"
  default     = "ami-95f8d2f3"
}

variable "keypair_name" {
  description = "ID of AMI for cluster EC2 machines"
}

variable "min_size" {
  description = "Minimum size of cluster autoscaling group"
  default     = 0
}

variable "max_size" {
  description = "Maximum size of cluster autoscaling group"
  default     = 4
}

variable "desired_capacity" {
  description = "Desired capacity of cluster autoscaling group"
  default     = 2
}
