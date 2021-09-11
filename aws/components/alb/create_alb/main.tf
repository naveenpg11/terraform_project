resource "aws_lb" "alb" {
  name               = var.alb-name
  load_balancer_type = "application"
  security_groups    = var.security-group
  subnets            = var.public-subnets

  enable_deletion_protection = var.enable-deletion-protection
  access_logs {
    bucket  = var.s3-name
    enabled = var.access-logs-enabled
  }

  tags = {
    "Name"              = var.alb-name
    "Application"  = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Application Role"  = var.approle
    "Deployment id"     = var.deployment-id
  }
}

output "lb-arn" {
  value = aws_lb.alb.arn
}

output "dns_name" {
  value = aws_lb.alb.dns_name
}

output "zone_id" {
  value = aws_lb.alb.zone_id
}
