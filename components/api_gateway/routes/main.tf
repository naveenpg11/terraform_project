resource "aws_apigatewayv2_route" "api" {
  api_id    = var.api_gateway_id
  route_key = "ANY /"

  target = "integrations/${var.api_integration_id}"
}

resource "aws_apigatewayv2_route" "default" {
  api_id    = var.api_gateway_id
  route_key = "$default"

  target = "integrations/${var.api_integration_id}"
}