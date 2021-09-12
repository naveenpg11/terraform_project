resource "aws_route_table" "dev-private-rt-1" {
  vpc_id = var.vpc-id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat-gateway-id
  }

  tags = var.tags
}


output "route_table_id" {
  value = aws_route_table.dev-private-rt-1.id
}
