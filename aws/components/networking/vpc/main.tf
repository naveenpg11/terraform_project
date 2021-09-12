resource "aws_vpc" "dev-vpc-1" {
  cidr_block           = var.cidrange
  enable_dns_hostnames = "true"

  tags = {
    "Name"              = var.vpc-name
    "Application"       = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Application Role"  = var.approle
    "Deployment id"     = var.deployment-id
  }
}

output "vpc_id" {
  value = aws_vpc.dev-vpc-1.id 
}

resource "aws_internet_gateway" "dev-gw-1" {
  vpc_id = aws_vpc.dev-vpc-1.id

  tags = {
    Name = var.gateway-name
  }
}

output "internet_gateway_id" {
  value = aws_internet_gateway.dev-gw-1.id
}

