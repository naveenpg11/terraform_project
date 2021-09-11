locals {
  vpc-name                             = format("%s-%s-%s-%s-%s-%s", var.client, var.vpc-name, var.appcode, var.env, var.locationcode, "01")
  gateway-name                         = format("%s-%s-%s-%s-%s-%s", var.client, var.gateway-name, var.appcode, var.env, var.locationcode, "01")
  nat-1-name                           = format("%s-%s-%s-%s-%s-%s", var.client, var.nat-name, var.appcode, var.env, var.locationcode, "01")
  nat-2-name                           = format("%s-%s-%s-%s-%s-%s", var.client, var.nat-name, var.appcode, var.env, var.locationcode, "02")
  public-nacl-name                     = format("%s-%s-%s-%s-%s-%s", var.client, var.nacl-name, var.pub-appcode, var.env, var.locationcode, "01")
  instance-private-nacl-name           = format("%s-%s-%s-%s-%s-%s", var.client, var.nacl-name, var.ins-appcode, var.env, var.locationcode, "02")
  eks-private-nacl-name                = format("%s-%s-%s-%s-%s-%s", var.client, var.nacl-name, var.eks-appcode, var.env, var.locationcode, "03")
  inventory-private-nacl-name          = format("%s-%s-%s-%s-%s-%s", var.client, var.nacl-name, var.inv-appcode, var.env, var.locationcode, "04")
  msk-private-nacl-name                = format("%s-%s-%s-%s-%s-%s", var.client, var.nacl-name, var.msk-appcode, var.env, var.locationcode, "05")
  public-route-table-name              = format("%s-%s-%s-%s-%s-%s", var.client, var.route-table-name, var.pub-appcode, var.env, var.locationcode, "01")
  instance-private-route-table-1-name  = format("%s-%s-%s-%s-%s-%s", var.client, var.route-table-name, var.ins-appcode, var.env, var.locationcode, "01")
  instance-private-route-table-2-name  = format("%s-%s-%s-%s-%s-%s", var.client, var.route-table-name, var.ins-appcode, var.env, var.locationcode, "02")
  eks-private-route-table-1-name       = format("%s-%s-%s-%s-%s-%s", var.client, var.route-table-name, var.eks-appcode, var.env, var.locationcode, "01")
  eks-private-route-table-2-name       = format("%s-%s-%s-%s-%s-%s", var.client, var.route-table-name, var.eks-appcode, var.env, var.locationcode, "02")
  inventory-private-route-table-1-name = format("%s-%s-%s-%s-%s-%s", var.client, var.route-table-name, var.inv-appcode, var.env, var.locationcode, "01")
  inventory-private-route-table-2-name = format("%s-%s-%s-%s-%s-%s", var.client, var.route-table-name, var.inv-appcode, var.env, var.locationcode, "02")
  msk-private-route-table-1-name       = format("%s-%s-%s-%s-%s-%s", var.client, var.route-table-name, var.msk-appcode, var.env, var.locationcode, "01")
  msk-private-route-table-2-name       = format("%s-%s-%s-%s-%s-%s", var.client, var.route-table-name, var.msk-appcode, var.env, var.locationcode, "02")
  security-group-name                  = format("%s-%s-%s-%s-%s-%s", var.client, var.security-group-name, var.appcode, var.env, var.locationcode, "01")
  vpn-security-group-name              = format("%s-%s-%s-%s-%s-%s", var.client, var.security-group-name, var.appcode, var.env, var.locationcode, "03")
  logstash-security-group-name         = format("%s-%s-%s-%s-%s-%s", var.client, var.security-group-name, var.appcode, var.env, var.locationcode, "02")
  log_1_name                           = format("%s-%s-%s-%s-%s-%s", var.client, "vpc", "logs", var.env, var.locationcode, "01")

  public-subnet-1-tags = {
    "Name"              = format("%s-%s-%s-%s-%s-%s", var.client, var.subnet-name, var.pub-appcode, var.env, var.locationcode, "01")
    "Application"       = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Deployment id"     = var.deployment-id
    "Application Role"  = var.snt-approle
  }

  public-subnet-2-tags = {
    "Name"              = format("%s-%s-%s-%s-%s-%s", var.client, var.subnet-name, var.pub-appcode, var.env, var.locationcode, "02")
    "Application"       = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Deployment id"     = var.deployment-id
    "Application Role"  = var.snt-approle
  }

   private-subnet-1-tags = {
    "Name"              = format("%s-%s-%s-%s-%s-%s", var.client, var.subnet-name, var.private-appcode, var.env, var.locationcode, "01")
    "Application"       = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Deployment id"     = var.deployment-id
    "Application Role"  = var.snt-approle
  }

   private-subnet-2-tags = {
    "Name"              = format("%s-%s-%s-%s-%s-%s", var.client, var.subnet-name, var.private-appcode, var.env, var.locationcode, "02")
    "Application"       = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Deployment id"     = var.deployment-id
    "Application Role"  = var.snt-approle
  }

  instance-subnet-1-tags = {
    "Name"              = format("%s-%s-%s-%s-%s-%s", var.client, var.subnet-name, var.ins-appcode, var.env, var.locationcode, "01")
    "Application"       = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Deployment id"     = var.deployment-id
    "Application Role"  = var.snt-approle
  }

  instance-subnet-2-tags = {
    "Name"              = format("%s-%s-%s-%s-%s-%s", var.client, var.subnet-name, var.ins-appcode, var.env, var.locationcode, "02")
    "Application"       = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Deployment id"     = var.deployment-id
    "Application Role"  = var.snt-approle
  }

  eks-subnet-1-tags = {
    "Name"                            = format("%s-%s-%s-%s-%s-%s", var.client, var.subnet-name, var.eks-appcode, var.env, var.locationcode, "01")
    "kubernetes.io/role/internal-elb" = "1"
    "Application"                     = var.appname
    "Application Owner"               = var.appowner
    "Environment"                     = var.environment
    "Deployment id"                   = var.deployment-id
    "Application Role"                = var.snt-approle
  }

  eks-subnet-2-tags = {
    "Name"                            = format("%s-%s-%s-%s-%s-%s", var.client, var.subnet-name, var.eks-appcode, var.env, var.locationcode, "02")
    "kubernetes.io/role/internal-elb" = "1"
    "Application"                     = var.appname
    "Application Owner"               = var.appowner
    "Environment"                     = var.environment
    "Deployment id"                   = var.deployment-id
    "Application Role"                = var.snt-approle
  }

  inventory-subnet-1-tags = {
    "Name"              = format("%s-%s-%s-%s-%s-%s", var.client, var.subnet-name, var.inv-appcode, var.env, var.locationcode, "01")
    "Application"       = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Deployment id"     = var.deployment-id
    "Application Role"  = var.snt-approle
  }

  inventory-subnet-2-tags = {
    "Name"              = format("%s-%s-%s-%s-%s-%s", var.client, var.subnet-name, var.inv-appcode, var.env, var.locationcode, "02")
    "Application"       = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Deployment id"     = var.deployment-id
    "Application Role"  = var.snt-approle
  }

  msk-subnet-1-tags = {
    "Name"              = format("%s-%s-%s-%s-%s-%s", var.client, var.subnet-name, var.msk-appcode, var.env, var.locationcode, "01")
    "Application"       = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Deployment id"     = var.deployment-id
    "Application Role"  = var.snt-approle
  }

  msk-subnet-2-tags = {
    "Name"              = format("%s-%s-%s-%s-%s-%s", var.client, var.subnet-name, var.msk-appcode, var.env, var.locationcode, "02")
    "Application"       = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Deployment id"     = var.deployment-id
    "Application Role"  = var.snt-approle
  }
}

module "vpc" {
  source        = "../../../components/networking/vpc"
  vpc_create    = var.vpc_create
  cidrange      = var.cidrange
  vpc-name      = local.vpc-name
  gateway_id    = var.gateway_id
  gateway-name  = local.gateway-name
  appname       = var.appname
  appowner      = var.appowner
  environment   = var.environment
  deployment-id = var.deployment-id
  approle       = var.vpc-approle
}

locals {
  vpc-id = module.vpc.vpc_id
}

module "public_subnet_1" {
  source                  = "../../../components/networking/subnets"
  tags                    = local.public-subnet-1-tags
  vpc_id                  = local.vpc-id
  subnet-block            = var.public-subnet-1-block
  az                      = var.az1
  map-public-ip-on-launch = true
  subnet_create           = var.public_subnet1_create
}

module "public_subnet_2" {
  source                  = "../../../components/networking/subnets"
  tags                    = local.public-subnet-2-tags
  vpc_id                  = local.vpc-id
  subnet-block            = var.public-subnet-2-block
  az                      = var.az2
  map-public-ip-on-launch = true
  subnet_create           = var.public_subnet2_create
}

module "private_subnet_1" {
  source                  = "../../../components/networking/subnets"
  tags                    = local.private-subnet-1-tags
  vpc_id                  = local.vpc-id
  subnet-block            = var.private-subnet-1-block
  az                      = var.az1
  map-public-ip-on-launch = true
  subnet_create           = var.public_subnet1_create
}

module "private_subnet_2" {
  source                  = "../../../components/networking/subnets"
  tags                    = local.private-subnet-2-tags
  vpc_id                  = local.vpc-id
  subnet-block            = var.private-subnet-2-block
  az                      = var.az2
  map-public-ip-on-launch = true
  subnet_create           = var.public_subnet2_create
}


module "nat_gateway_1" {
  source        = "../../../components/networking/nat_gateway"
  nat-name      = local.nat-1-name
  subnet-id     = module.public_subnet_1.subnet_id
  appname       = var.appname
  appowner      = var.appowner
  environment   = var.environment
  deployment-id = var.deployment-id
  approle       = var.nat-approle
}

module "nat_gateway_2" {
  source        = "../../../components/networking/nat_gateway"
  nat-name      = local.nat-2-name
  subnet-id     = module.public_subnet_2.subnet_id
  appname       = var.appname
  appowner      = var.appowner
  environment   = var.environment
  deployment-id = var.deployment-id
  approle       = var.nat-approle
}


module "nacl_public" {
  source        = "../../../components/networking/nacl"
  nacl-name     = local.public-nacl-name
  vpc-id        = local.vpc-id
  subnet-ids    = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
  appname       = var.appname
  appowner      = var.appowner
  environment   = var.environment
  deployment-id = var.deployment-id
  approle       = var.nacl-approle
}


module "nacl_private_instance" {
  source        = "../../../components/networking/nacl"
  nacl-name     = local.instance-private-nacl-name
  vpc-id        = local.vpc-id
  subnet-ids    = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id]
  appname       = var.appname
  appowner      = var.appowner
  environment   = var.environment
  deployment-id = var.deployment-id
  approle       = var.nacl-approle
}

module "public_route_table" {
  source                  = "../../../components/networking/route_table_public"
  public-route-table-name = local.public-route-table-name
  vpc-id                  = local.vpc-id
  internet-gateway-id     = module.vpc.internet_gateway_id
  appname                 = var.appname
  appowner                = var.appowner
  environment             = var.environment
  deployment-id           = var.deployment-id
  approle                 = var.rt-approle
}

module "public_route_table_association" {
  source         = "../../../components/networking/route_table_association"
  subnet-ids     = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
  route-table-id = module.public_route_table.route_table_id
}


module "security-group" {
  source              = "../../../components/networking/security_group"
  security-group-name = local.security-group-name
  vpc_id              = local.vpc-id
  appname             = var.appname
  appowner            = var.appowner
  environment         = var.environment
  deployment-id       = var.deployment-id
  approle             = var.sg-approle
}

module "sg_rule_vpc_cidr" {
  source            = "../../../components/networking/security_group_rules"
  type              = "ingress"
  from-port         = 22
  to-port           = 22
  protocol          = "tcp"
  cidr-blocks       = [var.cidrange]
  security-group-id = module.security-group.security_group_id
  description       = "Communicate Within VPC"
}

module "logstash-security-group" {
  source              = "../../../components/networking/security_group"
  security-group-name = local.logstash-security-group-name
  vpc_id              = local.vpc-id
  appname             = var.appname
  appowner            = var.appowner
  environment         = var.environment
  deployment-id       = var.deployment-id
  approle             = var.sg-approle
}


module "logstash_sg_rule_vpc_cidr" {
  source            = "../../../components/networking/security_group_rules"
  type              = "ingress"
  from-port         = 22
  to-port           = 22
  protocol          = "tcp"
  cidr-blocks       = [var.cidrange]
  security-group-id = module.logstash-security-group.security_group_id
  description       = "Communicate Within VPC"
}

module "logstash_sg_rule_vpc_cidr_1" {
  source            = "../../../components/networking/security_group_rules"
  type              = "ingress"
  from-port         = 5044
  to-port           = 5044
  protocol          = "tcp"
  cidr-blocks       = [var.cidrange]
  security-group-id = module.logstash-security-group.security_group_id
  description       = "Beats"
}

module "logstash_sg_rule_vpc_cidr_2" {
  source            = "../../../components/networking/security_group_rules"
  type              = "ingress"
  from-port         = 5045
  to-port           = 5045
  protocol          = "tcp"
  cidr-blocks       = [var.cidrange]
  security-group-id = module.logstash-security-group.security_group_id
  description       = "Beats"
}

module "logstash_sg_rule_vpc_cidr_3" {
  source            = "../../../components/networking/security_group_rules"
  type              = "ingress"
  from-port         = 9600
  to-port           = 9600
  protocol          = "tcp"
  cidr-blocks       = [var.cidrange]
  security-group-id = module.logstash-security-group.security_group_id
  description       = "Beats"
}



module "private_route_table_1" {
  source                   = "../../../components/networking/route_table_private"
  vpc-id                   = local.vpc-id
  nat-gateway-id           = module.nat_gateway_1.nat-id
  private-route-table-name = local.instance-private-route-table-1-name
  appname                  = var.appname
  appowner                 = var.appowner
  environment              = var.environment
  deployment-id            = var.deployment-id
  approle                  = var.rt-approle
}

module "private_route_table_1_association" {
  source         = "../../../components/networking/route_table_association"
  subnet-ids     = [module.private_subnet_1.subnet_id]
  route-table-id = module.private_route_table_1.route_table_id
}

module "private_route_table_2" {
  source                   = "../../../components/networking/route_table_private"
  vpc-id                   = local.vpc-id
  nat-gateway-id           = module.nat_gateway_2.nat-id
  private-route-table-name = local.instance-private-route-table-2-name
  appname                  = var.appname
  appowner                 = var.appowner
  environment              = var.environment
  deployment-id            = var.deployment-id
  approle                  = var.rt-approle
}

module "private_route_table_2_association" {
  source         = "../../../components/networking/route_table_association"
  subnet-ids     = [module.private_subnet_2.subnet_id]
  route-table-id = module.private_route_table_2.route_table_id
}
##########


locals {
  vpc-service-name-s3  = format("%s.%s.%s", "com.amazonaws", var.region, "s3")
  vpc-service-name-ddb = format("%s.%s.%s", "com.amazonaws", var.region, "dynamodb")
  s3-endpoint-name     = format("%s-%s-%s-%s-%s-%s", var.client, var.endpoint-name, var.appcode, var.env, var.locationcode, "01")
  ddb-endpoint-name    = format("%s-%s-%s-%s-%s-%s", var.client, var.endpoint-name, var.appcode, var.env, var.locationcode, "02")
  flow-log-name        = format("%s-%s-%s-%s-%s-%s", var.client, var.flow-log-name, var.appcode, var.env, var.locationcode, "01")
}


#creating vpc log bucket

module "logs_1_bucket" {
  source                     = "../../../components/s3"
  bucket-name                = local.log_1_name
  appname                    = var.appname
  appowner                   = var.appowner
  environment                = var.environment
  approle                    = var.approle
  deployment-id              = var.deployment-id
  enable-deletion-protection = var.enable-deletion-protection
}

module "flow_log" {
  count         = var.enable-vpc-logs ? 1 : 0
  source        = "../../../components/flow_logs"
  s3-arn        = module.logs_1_bucket.s3_arn
  traffic-type  = var.flow-log-traffic-type
  vpc-id        = local.vpc-id
  flow-log-name = local.flow-log-name
  appname       = var.appname
  appowner      = var.appowner
  environment   = var.environment
  approle       = var.approle
  deployment-id = var.deployment-id

}

module "vpn-security-group" {
  source              = "../../../components/networking/security_group"
  security-group-name = local.vpn-security-group-name
  vpc_id              = local.vpc-id
  appname             = var.appname
  appowner            = var.appowner
  environment         = var.environment
  approle             = var.sg-approle
  deployment-id       = var.deployment-id
}

module "vpn_sg_rule_vpc_cidr" {
  source            = "../../../components/networking/security_group_rules"
  type              = "ingress"
  from-port         = 0
  to-port           = 65535
  protocol          = "tcp"
  cidr-blocks       = [var.vpn-ip]
  security-group-id = module.vpn-security-group.security_group_id
  description       = "VPN Access"
}

output "nat_gateway_1_id" {
  value = module.nat_gateway_1.nat-id
}

output "nat_gateway_2_id" {
  value = module.nat_gateway_1.nat-id
}

output "vpc_id" {
  value = local.vpc-id
}

output "public_subnet_1_id" {
  value = module.public_subnet_1.subnet_id
}
output "public_subnet_2_id" {
  value = module.public_subnet_2.subnet_id
}

output "private_subnet_1_id" {
  value = module.private_subnet_1.subnet_id
}
output "private_subnet_2_id" {
  value = module.private_subnet_2.subnet_id
}



output "security_group_id" {
  value = module.security-group.security_group_id
}

output "vpn_security_group_id" {
  value = module.vpn-security-group.security_group_id
}
output "logstash_security_group_id" {
  value = module.logstash-security-group.security_group_id
}

output "route-table-id" {
  value = module.public_route_table.route_table_id
}
