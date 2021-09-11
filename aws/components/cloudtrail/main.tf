resource "aws_cloudtrail" "Trail" {
  name                          = var.trail-name
  s3_bucket_name                = var.s3-name
  include_global_service_events = false
  cloud_watch_logs_group_arn    = var.cloudwatch-arn
  cloud_watch_logs_role_arn     = var.cloudwatch-role-arn

  tags = {
    "Name"              = var.trail-name
    "Application"  = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Application Role"  = var.approle
    "Deployment id"     = var.deployment-id
  }
  
}
