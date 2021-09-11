resource "aws_apigatewayv2_stage" "api" {
  api_id = var.api_gw_id
  name   = "$default"
  auto_deploy = true
}