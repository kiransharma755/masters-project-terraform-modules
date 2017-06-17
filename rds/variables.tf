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

variable "db_subnet_group_name" {
  description = "Database subnet group name"
}

variable "parameter_group_name" {
  description = "Parameter group for DB instance"
}
