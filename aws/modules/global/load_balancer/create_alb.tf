locals {
  # alb-security-group-name = format("%s-%s-%s-%s-%s-%s", var.client, var.alb-security-group-name, var.alb-appcode, var.env, var.locationcode, "01")
  alb-name                = format("%s-%s-%s-%s-%s-%s", var.client, var.alb-name, var.appcode, var.env, var.locationcode, "01")
  log_2_name              = format("%s-%s-%s-%s-%s-%s", var.client, "alb", "logs", var.env, var.locationcode, "01")
  target-group-name       = "tg-8000"
  alb-security-group-name = "alb-sg"
}

#creating bucket alb logs 

# data "aws_elb_service_account" "main" {}

# module "logs_alb_bucket" {
#   source                     = "../../../components/s3"
#   bucket-name                = local.log_2_name
#   appname                    = var.appname
#   appowner                   = var.appowner
#   environment                = var.environment
#   approle                    = var.approle
#   deployment-id              = var.deployment-id
#   enable-deletion-protection = var.enable-deletion-protection

#   policy = <<POLICY
# {
#   "Id": "Policy",
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "s3:PutObject"
#       ],
#       "Effect": "Allow",
#       "Resource": "arn:aws:s3:::${local.log_2_name}/AWSLogs/*",
#       "Principal": {
#         "AWS": [
#           "${data.aws_elb_service_account.main.arn}"
#         ]
#       }
#     }
#   ]
# }
# POLICY
# }


module "alb-sg" {
  source              = "../../../components/networking/security_group"
  security-group-name = local.alb-security-group-name
  vpc_id              = var.vpc-id
  appname             = var.alb-appname
  appowner            = var.appowner
  environment         = var.environment
  deployment-id       = var.deployment-id
}

module "sg_rule_http_alb" {
  source            = "../../../components/networking/security_group_rules"
  type              = "ingress"
  from-port         = 80
  to-port           = 80
  protocol          = "tcp"
  cidr-blocks       = ["0.0.0.0/0"]
  security-group-id = module.alb-sg.security_group_id
  description       = "ELK"
}


module "alb" {
  source                     = "../../../components/alb/create_alb"
  alb-name                   = local.alb-name
  security-group             = [module.alb-sg.security_group_id, module.vpn-security-group.security_group_id]
  public-subnets             = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id]
  appname                    = var.alb-appname
  appowner                   = var.appowner
  environment                = var.environment
  deployment-id              = var.deployment-id
  approle                    = var.alb-approle
  enable-deletion-protection = var.enable-deletion-protection
  s3-name                    = module.logs_alb_bucket.s3_name
  access-logs-enabled        = var.enable-alb-logs
}


# module "target_group" {
#   source                = "../../../components/alb/target_group"
#   target-group-name     = local.target-group-name
#   port                  = var.tg-port
#   protocol              = var.tg-protocol
#   vpc-id                = var.vpc-id
#   instance-ids          = module.solr.ec2-instance.*.id
#   health-check-protocol = var.health-check-protocol
#   health-check-path     = var.health-check-path
#   health-check-port     = var.health-check-port
#   healthy-threshold     = var.healthy-threshold
#   unhealthy-threshold   = var.unhealthy-threshold
#   health-check-timeout  = var.health-check-timeout
#   health-check-interval = var.health-check-interval
#   health-check-matcher  = var.health-check-matcher
#   appname               = var.tg-appname
#   appowner              = var.appowner
#   environment           = var.environment
#   deployment-id         = var.deployment-id
#   approle               = var.tg-approle
# }

# module "alb-listener" {
#   source           = "../../../components/alb/listener"
#   lb-arn           = var.alb-arn
#   port             = var.listener-port
#   protocol         = var.listener-protocol
#   target-group-arn = module.target_group.tg-arn
# }


output "alb-arn" {
  value = module.alb.lb-arn
}

output "solr-alb-dns_name" {
  value = module.alb.dns_name
}

output "alb-dns_name" {
  value = module.alb.dns_name
}

output "alb-zone-id" {
  value = module.alb.zone_id
}

