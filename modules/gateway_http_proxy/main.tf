# locals{

#     route_key_local  = format("%s%s", "ANY http://",var.lb_dns_name,"/")

# }


resource "aws_apigatewayv2_api" "api" {
  name          = "example-http-api-private"
  protocol_type = "HTTP"
}

module "proxy_integration" {
  source = "../../components/api_gateway/api_integrations_proxy"
  lb_dns_name = var.lb_dns_name
  api_gateway_id = aws_apigatewayv2_api.api.id
}

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