variable "env" {
  description = "The environment"
}

variable "vpc_id" {
  description = "Id of VPC to provision the instance to"
}

variable "ami" {
  description = "AMI for the instance"
  default     = "ami-01ccc867"
}

variable "instance_type" {
  description = "Type of instance to provision"
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Id of subnet to provision the instance to"
}

variable "key_name" {
  description = "Name of SSH key pair"
}

variable "allowed_hosts" {
  type        = "list"
  description = "CIDR block of allowed hosts"
}
