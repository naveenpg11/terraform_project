resource "aws_security_group" "dev-secg-1" {
  name        = var.security-group-name
  description = "Allow Traffic"
  vpc_id      = var.vpc_id

  tags =  var.tags

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_group_id" {
  value = aws_security_group.dev-secg-1.id
}
