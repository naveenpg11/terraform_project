resource "aws_route_table" "dev-public-rt-1" {
  vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet-gateway-id
  }

  tags = {
    "Name"              = var.public-route-table-name
    "Application"  = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Application Role"  = var.approle
    "Deployment id"     = var.deployment-id
  }
}

output "route_table_id" {
  value = aws_route_table.dev-public-rt-1.id
}
