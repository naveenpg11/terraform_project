terraform {
  required_providers {
    aws = {
      version = "~> 3.24.1"
    }
    null = {
      version = "2.1"
    }
  }
  # backend "s3" {
  #   bucket = "iac-madstack-1"
  #   key    = "<<date>>/terraform.tfstate"
  #   region = "ap-south-1"
  # }
}

provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu-18_04" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

module "vpc" {
  source                     = "./modules/networking"
  cidrange                   = var.cidrange
  public-subnet-1-block      = var.public-subnet-1-block
  public-subnet-2-block      = var.public-subnet-2-block
  private-subnet-1-block      = var.private-subnet-1-block
  private-subnet-2-block      = var.private-subnet-2-block
  az1                        = var.az1
  az2                        = var.az2
  env                        = var.env
  locationcode               = lookup(var.locationcode, var.region)
  deployment_id              = var.deployment_id
  enable-vpc-logs            = var.enable-vpc-logs
  created_by                 = var.created_by
  enable-deletion-protection  = false
}


module "load_balancer" {
  source                     = "./modules/load_balancer"
  vpc_id                     = module.vpc.vpc_id
  vpc_cidr_block             = var.cidrange
  private_subnet_1_id        = module.vpc.private_subnet_1_id
  private_subnet_2_id        = module.vpc.private_subnet_2_id
  env                        = var.env
  locationcode               = lookup(var.locationcode, var.region)
  deployment_id              = var.deployment_id
  enable-deletion-protection = var.enable-deletion-protection
  enable-alb-logs            = var.enable-alb-logs
  created_by                 = var.created_by
}


# module "container-task-def" {
#   source                     = "./modules/global/ecs"
#   container_name             = "container-api"
#   container_image_id         = var.container_image_id
# }

module "ecs_service" {
  source       = "./modules/ecs_deploy"
  vpc_id       = module.vpc.vpc_id
  vpc_cidr_block             = var.cidrange
  private_subnet_1_id         = module.vpc.private_subnet_1_id
  private_subnet_2_id         = module.vpc.private_subnet_2_id
  target_group_arn           = module.load_balancer.target_group_arn
  container_image_id         = var.container_image_id

  env                        = var.env
  locationcode               = lookup(var.locationcode, var.region)
  created_by                 = var.created_by
  deployment_id              = var.deployment_id

  application_container_port = var.application_container_port
  depends_on = [module.vpc]
  
}


# module "expose_api_https" {
#   source = "./modules/gateway_http_proxy"
#   lb_dns_name = module.load_balancer.alb-dns_name
# }

module "expose_api_https_private" {
  source = "./modules/gateway_https_private"
  vpc_id       = module.vpc.vpc_id
  private_subnet_1_id         = module.vpc.private_subnet_1_id
  private_subnet_2_id         = module.vpc.private_subnet_2_id
  alb_listener_arn            = module.load_balancer.alb_listener_arn
  env                        = var.env
  locationcode               = lookup(var.locationcode, var.region)
  created_by                 = var.created_by
  deployment_id              = var.deployment_id

  depends_on = [module.vpc, module.load_balancer]
}

