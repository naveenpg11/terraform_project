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
  source                     = "./modules/global/networking"
  vpc_create                 = var.vpc_create
  cidrange                   = var.cidrange
  gateway_id                 = var.gateway_id
  public-subnet-1-block      = var.public-subnet-1-block
  public-subnet-2-block      = var.public-subnet-2-block

  private-subnet-1-block      = var.private-subnet-1-block
  private-subnet-2-block      = var.private-subnet-2-block


  az1                        = var.az1
  az2                        = var.az2
  client                     = var.client
  env                        = var.env
  locationcode               = lookup(var.locationcode, var.region)

  public_subnet1_create      = var.public_subnet1_create
  public_subnet2_create      = var.public_subnet2_create
  
  private_subnet1_create      = var.private_subnet1_create
  private_subnet2_create      = var.private_subnet2_create


  appowner                   = var.appowner
  environment                = var.environment
  deployment-id              = var.deployment-id
  region                     = var.region
  enable-deletion-protection = var.enable-deletion-protection
  aws_account_id             = var.aws_account_id
  enable-vpc-logs            = var.enable-vpc-logs
  enable-alb-logs            = var.enable-alb-logs
  vpn-ip                     = var.vpn-ip
}


module "container-task-def" {
  source                     = "./modules/global/ecs"
  container-image-id         = var.container-image-id
}

module "ecs_service" {
  source       = "./modules/ecs_deploy"
  vpc_id       = module.vpc.vpc_id
  private_subnet_1_id         = module.vpc.private_subnet_1_id
  private_subnet_2_id         = module.vpc.private_subnet_2_id
  target_group_arn           = module.vpc.target_group_arn
  container_task_def_arn     = module.container-task-def.task_definition_id

  depends_on = [module.vpc]
}


module "expose_api_https" {
  source = "./modules/gateway_http_proxy"
  lb_dns_name = module.vpc.alb-dns_name
}

module "expose_api_https_private" {
  source = "./modules/gateway_https_private"
  vpc_id       = module.vpc.vpc_id
  private_subnet_1_id         = module.vpc.private_subnet_1_id
  private_subnet_2_id         = module.vpc.private_subnet_2_id
  alb_listener_arn            = module.vpc.alb_listener_arn
}

