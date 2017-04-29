variable "cidr" {
  description = "CIDR block for VPC"
}

variable "enable_dns_hostnames" {
  description = "Boolean flag to enable/disable DNS hostnames in the VPC."
  default     = true
}

variable "public_subnets" {
  description = "CIDR block list of public subnets"
  type        = "list"
}

variable "private_subnets" {
  description = "CIDR block list of private subnets"
  type        = "list"
}
