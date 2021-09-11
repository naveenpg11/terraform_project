resource "aws_security_group_rule" "dev-rule-1" {
  type                     = var.type
  from_port                = var.from-port
  to_port                  = var.to-port
  protocol                 = var.protocol
  cidr_blocks              = var.cidr-blocks
  security_group_id        = var.security-group-id
  description              = var.description
  source_security_group_id = var.source-sg
}
