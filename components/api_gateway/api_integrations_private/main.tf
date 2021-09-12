
resource "aws_apigatewayv2_integration" "api" {
  api_id           = var.api_gateway_id
  # credentials_arn  = aws_iam_role.example.arn
  description      = "APIGatewayV2 load balancer Integration"
  integration_type = "HTTP_PROXY"
  integration_uri  = var.alb_listener_arn

  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      =  var.vpc_link_id
  }

output "api_integration_id" {
    value = aws_apigatewayv2_integration.api.id
}