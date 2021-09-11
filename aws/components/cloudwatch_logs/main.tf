resource "aws_cloudwatch_log_group" "msd" {
  name = var.name
  retention_in_days = var.retention_in_days

  tags = {
    "Name"              = var.name
    "Application"  = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Application Role"  = var.approle
    "Deployment id"     = var.deployment-id
  }
}

output "log-arn" {
  value = aws_cloudwatch_log_group.msd.arn
}
output "log-name" {
  value = aws_cloudwatch_log_group.msd.name
}