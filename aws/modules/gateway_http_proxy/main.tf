# locals{

#     route_key_local  = format("%s%s", "ANY http://",var.lb_dns_name,"/")

# }


resource "aws_apigatewayv2_api" "api" {
  name          = "example-http-api-private"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "api" {
  api_id           = aws_apigatewayv2_api.api.id
  integration_type = "HTTP_PROXY"

  integration_method = "ANY"
  integration_uri    = "http://${var.lb_dns_name}"
}

resource "aws_apigatewayv2_route" "api" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "ANY /"

  target = "integrations/${aws_apigatewayv2_integration.api.id}"
}

resource "aws_apigatewayv2_route" "default" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "$default"

  target = "integrations/${aws_apigatewayv2_integration.api.id}"
}


# resource "aws_apigatewayv2_deployment" "api" {
#   api_id      = aws_apigatewayv2_route.api.api_id
#   description = "Example"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "aws_apigatewayv2_stage" "api" {
  api_id = aws_apigatewayv2_api.api.id
  name   = "$default"
  auto_deploy = true

}

output "https_endpoint"{
    value = aws_apigatewayv2_api.api.api_endpoint
}