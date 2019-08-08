provider "aws" {
  region = "eu-central-1"
}

/*
module "vpc-default" {
  source = "../modules/aws_network"
}
*/

#=========================Creation VPC===================================

module "vpc-dev" {
  source               = "../modules/aws_network"
  env                  = "development"
  vpc_cidr             = "10.100.0.0/16"
  public_subnet_cidrs  = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnet_cidrs = []
}

module "vpc-prod" {
  source               = "../modules/aws_network"
  env                  = "production"
  vpc_cidr             = "10.100.0.0/16"
  public_subnet_cidrs  = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnet_cidrs = ["10.100.11.0/24", "10.100.22.0/24"]
}

#============================Creation Security Group=============================

module "securitygroup-dev" {
  source                   = "../modules/aws_securitygroup"
  allow_ports              = ["443", "80", "22", "8080"]
  enable_detail_monitoring = false
  common_tags = {
    Owner       = "Patrick"
    Project     = "My_Project"
    CostCenter  = "12345"
    Environment = "development"
  }
}

module "securitygroup-prod" {
  source                   = "../modules/aws_securitygroup"
  allow_ports              = ["443"]
  enable_detail_monitoring = false
  common_tags = {
    Owner       = "Patrick"
    Project     = "My_Project"
    CostCenter  = "12345"
    Environment = "production"
  }
}

#=============================Outputs=======================================

output "prod_public_subnet_ids" {
  value = module.vpc-prod.public_subnet_ids
}

output "prod_private_subnet_ids" {
  value = module.vpc-prod.private_subnet_ids
}

output "dev_public_subnet_ids" {
  value = module.vpc-dev.public_subnet_ids
}

output "dev_private_subnet_ids" {
  value = module.vpc-dev.private_subnet_ids
}
