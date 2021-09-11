resource "aws_subnet" "dev-subnet" {
  count = var.subnet_create == "true" ? 1 : 0
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet-block
  availability_zone       = var.az
  map_public_ip_on_launch = var.map-public-ip-on-launch

  tags = var.tags
}

output "subnet_id" {
  value = var.subnet_create == "true" ? aws_subnet.dev-subnet[0].id : var.subnet_create
}
