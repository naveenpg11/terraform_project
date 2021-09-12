resource "aws_apigatewayv2_integration" "api" {
  api_id           = var.api_gateway_id
  integration_type = "HTTP_PROXY"

  integration_method = "ANY"
  integration_uri    = "http://${var.lb_dns_name}"
}

output "api_integration_id" {
  value       = aws_apigatewayv2_integration.api.id
}
