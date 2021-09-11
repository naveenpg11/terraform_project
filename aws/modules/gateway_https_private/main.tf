# locals{

#     route_key_local  = format("%s%s", "ANY http://",var.lb_dns_name,"/")

# }


resource "aws_apigatewayv2_api" "api" {
  name          = "example-http-api-private"
  protocol_type = "HTTP"
}

# resource "aws_apigatewayv2_integration" "api" {
#   api_id           = aws_apigatewayv2_api.api.id
#   integration_type = "HTTP_PROXY"

#   integration_method = "ANY"
#   integration_uri    = "http://${var.lb_dns_name}"
# }

################## VPC LINK / And its integrations

resource "aws_security_group" "api-gw-sg" {
  name        = "allow-all-api"
  description = "allow all"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_apigatewayv2_vpc_link" "example" {
  name               = "example"
  security_group_ids = [aws_security_group.api-gw-sg.id]
  subnet_ids         = [var.private_subnet_1_id, var.private_subnet_2_id]

}

resource "aws_apigatewayv2_integration" "api" {
  api_id           = aws_apigatewayv2_api.api.id
  # credentials_arn  = aws_iam_role.example.arn
  description      = "Example with a load balancer"
  integration_type = "HTTP_PROXY"
  integration_uri  = var.alb_listener_arn

  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.example.id

  
}





##################
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