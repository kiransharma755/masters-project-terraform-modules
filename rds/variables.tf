variable "env" {
  description = "The environment"
}

variable "name" {
  description = "Name of the database"
}

variable "allocated_storage" {
  description = "Size of disk to attach to the RDS instance"
  default     = "10"
}

variable "storage_type" {
  description = "Type of disk to attach to the RDS instance"
  default     = "gp2"
}

variable "engine" {
  description = "RDS engine of the instance (PostgreSQL/MySQL)"
}

variable "engine_version" {
  description = "Engine version of the RDS instance"
}

variable "port" {
  description = "The port which the instance listens to"
  type        = "map"

  default = {
    postgresql = 5432
    mysql      = 3306
  }
}

variable "instance_class" {
  description = "Class of RDS instance"
  default     = "db.t1.micro"
}

variable "publicly_accessible" {
  description = "Parameter group for DB instance"
}

variable "username" {
  description = "DB username"
}

variable "password" {
  description = "DB password"
}

variable "parameter_group_name" {
  description = "Parameter group for DB instance"
  default     = ""
}

variable "subnets" {
  description = "List of subnets to place RDS instance into"
  type        = "list"
}

variable "zone_id" {
  description = "ID of Route53 zone"
}

variable "ttl" {
  description = "TTL for Route53 record"
  default     = "900"
}

variable "vpc_id" {
  description = "ID of VPC related to the RDS instance"
}

variable "allowed_security_group_id" {
  description = "ID of security group allowed to access the DB"
}

variable "bastion_ip" {
  description = "IP address of bastion"
}
