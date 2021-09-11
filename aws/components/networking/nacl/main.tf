resource "aws_network_acl" "dev-nacl" {
  vpc_id     = var.vpc-id
  subnet_ids = var.subnet-ids

  egress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    "Name"              = var.nacl-name
    "Application"  = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Application Role"  = var.approle
    "Deployment id"     = var.deployment-id
  }
}

output "nacl_id" {
  value = aws_network_acl.dev-nacl.id
}
