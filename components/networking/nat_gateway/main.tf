resource "aws_eip" "dev-eip" {
  vpc = true

  tags = {
    "Name" = "msd-eip"
  }
}

resource "aws_nat_gateway" "dev-nat-gw-1" {
  allocation_id = aws_eip.dev-eip.id
  subnet_id     = var.subnet-id

  tags = var.tags
}

output "nat-id" {
  value = aws_nat_gateway.dev-nat-gw-1.id
}
