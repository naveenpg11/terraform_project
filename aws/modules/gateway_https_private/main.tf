
resource "aws_apigatewayv2_api" "api" {
  name          = "example-http-api-private"
  protocol_type = "HTTP"
}

# resource "aws_security_group" "api-gw-sg" {
#   name        = "allow-all-api"
#   description = "allow all"
#   vpc_id      = var.vpc_id
#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }


locals {
appname =  "appname"
appowner =  "naveen"
environment = "dev"
deployment-id = "asdad"
approle = "vsd"
security-group-name = "vpc_link_sg"
}

module "vpc_link_sg_ecs" {
  source              = "../../components/networking/security_group"
  security-group-name = local.security-group-name
  vpc_id              = var.vpc_id
  appname             = local.appname
  appowner            = local.appowner
  environment         = local.environment
  deployment-id       = local.deployment-id
  approle             = local.approle
}

module "vpc_link_sg_rule" {
  source            = "../../components/networking/security_group_rules"
  type              = "ingress"
  from-port         = 80
  to-port           = 80
  protocol          = "tcp"
  cidr-blocks       = ["0.0.0.0/0"]
  security-group-id = module.vpc_link_sg_ecs.security_group_id
  description       = "launch_config_sg_ecs_rule"
}


module "vpc_link" {
  source = "../../components/api_gateway/vpc_link"
  security_group_vpc_link = module.vpc_link_sg_ecs.security_group_id
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