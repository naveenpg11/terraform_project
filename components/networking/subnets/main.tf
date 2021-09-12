resource "aws_subnet" "dev-subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet-block
  availability_zone       = var.az
  map_public_ip_on_launch = var.map-public-ip-on-launch

  tags = var.tags
}

output "subnet_id" {
  value = aws_subnet.dev-subnet.id 
}
