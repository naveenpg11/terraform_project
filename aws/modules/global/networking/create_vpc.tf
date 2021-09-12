locals {
  vpc-name                             = format("%s-%s-%s-%s-%s-%s", var.client, var.vpc-name, var.appcode, var.env, var.locationcode, "01")
  gateway-name                         = format("%s-%s-%s-%s-%s-%s", var.client, var.gateway-name, var.appcode, var.env, var.locationcode, "01")
  nat-1-name                           = format("%s-%s-%s-%s-%s-%s", var.client, var.nat-name, var.appcode, var.env, var.locationcode, "01")
  nat-2-name                           = format("%s-%s-%s-%s-%s-%s", var.client, var.nat-name, var.appcode, var.env, var.locationcode, "02")
  public-nacl-name                     = format("%s-%s-%s-%s-%s-%s", var.client, var.nacl-name, var.pub-appcode, var.env, var.locationcode, "01")
  private-nacl-name                     = format("%s-%s-%s-%s-%s-%s", var.client, var.nacl-name, var.private-appcode, var.env, var.locationcode, "01")  
  public-route-table-name              = format("%s-%s-%s-%s-%s-%s", var.client, var.route-table-name, var.pub-appcode, var.env, var.locationcode, "01")
  private-route-table-name              = format("%s-%s-%s-%s-%s-%s", var.client, var.route-table-name, var.private-appcode, var.env, var.locationcode, "01")
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

module "public_subnet_1" {
  source                  = "../../../components/networking/subnets"
  tags                    = local.public-subnet-1-tags
  vpc_id                  = module.vpc.vpc_id
  subnet-block            = var.public-subnet-1-block
  az                      = var.az1
  map-public-ip-on-launch = true
  subnet_create           = var.public_subnet1_create
}

module "public_subnet_2" {
  source                  = "../../../components/networking/subnets"
  tags                    = local.public-subnet-2-tags
  vpc_id                  = module.vpc.vpc_id
  subnet-block            = var.public-subnet-2-block
  az                      = var.az2
  map-public-ip-on-launch = true
  subnet_create           = var.public_subnet2_create
}

module "private_subnet_1" {
  source                  = "../../../components/networking/subnets"
  tags                    = local.private-subnet-1-tags
  vpc_id                  = module.vpc.vpc_id
  subnet-block            = var.private-subnet-1-block
  az                      = var.az1
  map-public-ip-on-launch = true
  subnet_create           = var.public_subnet1_create
}

module "private_subnet_2" {
  source                  = "../../../components/networking/subnets"
  tags                    = local.private-subnet-2-tags
  vpc_id                  = module.vpc.vpc_id
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
  vpc-id        = module.vpc.vpc_id
  subnet-ids    = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
  appname       = var.appname
  appowner      = var.appowner
  environment   = var.environment
  deployment-id = var.deployment-id
  approle       = var.nacl-approle
}


module "nacl_private_instance" {
  source        = "../../../components/networking/nacl"
  nacl-name     = local.private-nacl-name
  vpc-id        = module.vpc.vpc_id
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
  vpc-id                  = module.vpc.vpc_id
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

module "private_route_table" {
  source                   = "../../../components/networking/route_table_private"
  vpc-id                   = module.vpc.vpc_id
  nat-gateway-id           = module.nat_gateway_1.nat-id
  private-route-table-name = local.private-route-table-name
  appname                  = var.appname
  appowner                 = var.appowner
  environment              = var.environment
  deployment-id            = var.deployment-id
  approle                  = var.rt-approle
}

module "private_route_table_association" {
  source         = "../../../components/networking/route_table_association"
  subnet-ids     = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id ]
  route-table-id = module.private_route_table.route_table_id
}

# module "private_route_table_2" {
#   source                   = "../../../components/networking/route_table_private"
#   vpc-id                   = module.vpc.vpc_id
#   nat-gateway-id           = module.nat_gateway_2.nat-id
#   private-route-table-name = local.instance-private-route-table-2-name
#   appname                  = var.appname
#   appowner                 = var.appowner
#   environment              = var.environment
#   deployment-id            = var.deployment-id
#   approle                  = var.rt-approle
# }

# module "private_route_table_2_association" {
#   source         = "../../../components/networking/route_table_association"
#   subnet-ids     = [module.private_subnet_2.subnet_id]
#   route-table-id = module.private_route_table_2.route_table_id
# }
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
  # count                      = var.enable-vpc-logs ? 1 : 0
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
  vpc-id        = module.vpc.vpc_id
  flow-log-name = local.flow-log-name
  appname       = var.appname
  appowner      = var.appowner
  environment   = var.environment
  approle       = var.approle
  deployment-id = var.deployment-id

}
output "vpc_id" {
  value = module.vpc.vpc_id
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
