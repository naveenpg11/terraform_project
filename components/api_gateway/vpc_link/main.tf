resource "aws_apigatewayv2_vpc_link" "link" {
  name               = "example"
  security_group_ids = [var.security_group_vpc_link]
  subnet_ids         = [var.private_subnet_1_id, var.private_subnet_2_id]
}


output "vpc_link_id" {
  value       = aws_apigatewayv2_vpc_link.link.id
}
