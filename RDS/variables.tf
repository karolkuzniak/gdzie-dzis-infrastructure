variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "ec2_security_group_id" {
  type        = string
  description = "Security group ID of EC2"
}