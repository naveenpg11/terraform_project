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



module "vpc_link" {
  source = "../../components/api_gateway/vpc_link"
  security_group_vpc_link = aws_security_group.api-gw-sg.id
  private_subnet_1_id = var.private_subnet_1_id
  private_subnet_2_id = var.private_subnet_2_id
}

module "proxy_integration" {
  source = "../../components/api_gateway/api_integrations_private"
  api_gateway_id = aws_apigatewayv2_api.api.id
  vpc_link_id = module.vpc_link.vpc_link_id
  alb_listener_arn = var.alb_listener_arn
}



##################
module "creating_routes" {
  source = "../../components/api_gateway/routes"
  api_integration_id = module.proxy_integration.api_integration_id
  api_gateway_id = aws_apigatewayv2_api.api.id

  depends_on = [module.proxy_integration]
}

module "stage_deploy" {
  source = "../../components/api_gateway/stage_deploy"
  api_gw_id = aws_apigatewayv2_api.api.id

  depends_on = [module.creating_routes]
} 

output "https_endpoint"{
    value = aws_apigatewayv2_api.api.api_endpoint
}