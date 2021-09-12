resource "aws_vpc" "dev-vpc-1" {
  cidr_block           = var.cidrange
  enable_dns_hostnames = "true"

  tags = var.tags
}

output "vpc_id" {
  value = aws_vpc.dev-vpc-1.id 
}

resource "aws_internet_gateway" "dev-gw-1" {
  vpc_id = aws_vpc.dev-vpc-1.id

  tags = var.gateway_tags
}

output "internet_gateway_id" {
  value = aws_internet_gateway.dev-gw-1.id
}

