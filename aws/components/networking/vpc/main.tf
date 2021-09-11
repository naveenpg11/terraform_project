resource "aws_vpc" "dev-vpc-1" {
  count                = var.vpc_create == "true" ? 1 : 0
  cidr_block           = var.cidrange
  enable_dns_hostnames = "true"

  tags = {
    "Name"              = var.vpc-name
    "Application"  = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Application Role"  = var.approle
    "Deployment id"     = var.deployment-id
  }
}

output "vpc_id" {
  value = var.vpc_create == "true" ? aws_vpc.dev-vpc-1[0].id : var.vpc_create
}

resource "aws_internet_gateway" "dev-gw-1" {
  count  = var.vpc_create == "true" ? 1 : 0
  vpc_id = aws_vpc.dev-vpc-1[0].id

  tags = {
    Name = var.gateway-name
  }
}

output "internet_gateway_id" {
  value = var.vpc_create == "true" ? aws_internet_gateway.dev-gw-1[0].id : var.gateway_id
}

