Common Terraform modules for the course TKO_5328 Master's Project at University of Turku.

Title of the project: "Infrastructure as Code on AWS using Terraform"

Usage example: [tatusl/masters-project-infra](https://github.com/tatusl/masters-project-infra)

## Modules

### state_bucket

S3 bucket for storing Terraform state files

### account

Account-wide SSH key pair to be used in EC2 instances

### vpc

Multi-AZ (2 AZs) VPC with public and private subnets

### bastion

EC2 bastion host used to connect ECS cluster instances and RDS instances

### ecs

ECS cluster

### application

ECS service, ECS task definition, and ELB for application.

### rds

PostgreSQL/MySQL instance with Route53 record (CNAME)
