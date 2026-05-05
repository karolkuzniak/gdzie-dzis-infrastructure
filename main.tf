terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
    required_version = ">= 1.0"
}

provider "aws" {
    region = var.aws_region
}

module "vpc" {
    source = "./VPC"

    project_name = var.project_name
    environment  = var.environment
    aws_region   = var.aws_region
}

module "s3" {
    source = "./S3"

    project_name    = var.project_name
    environment     = var.environment
}

module "iam" {
    source = "./IAM"

    project_name    = var.project_name
    environment     = var.environment
    s3_bucket_arn   = module.s3.bucket_arn
}

module "rds" {
    source = "./RDS"

    project_name          = var.project_name
    environment           = var.environment
    vpc_id                = module.vpc.vpc_id
    private_subnet_id     = module.vpc.private_subnet_id
    public_subnet_id      = module.vpc.public_subnet_id
    db_password           = var.db_password
    ec2_security_group_id = module.ec2.security_group_id
}

module "ec2" {
    source = "./EC2"

    project_name     = var.project_name
    environment      = var.environment
    vpc_id           = module.vpc.vpc_id
    public_subnet_id = module.vpc.public_subnet_id
    instance_profile_name = module.iam.instance_profile_name
}

