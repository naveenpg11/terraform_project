locals {
  gateway_name                         = format("%s-%s-%s-%s-%s", var.deployment_id, "igw", var.env, var.locationcode, "01")
  nat-1-name                           = format("%s-%s-%s-%s-%s", var.deployment_id, "nat", var.env, var.locationcode, "01")
  nat-2-name                           = format("%s-%s-%s-%s-%s", var.deployment_id, "nat", var.env, var.locationcode, "02")
  public-nacl-name                     = format("%s-%s-%s-%s-%s", var.deployment_id, "nacl-public", var.env, var.locationcode, "01")
  private-nacl-name                    = format("%s-%s-%s-%s-%s", var.deployment_id, "nacl-private", var.env, var.locationcode, "01")  
  public-route-table-name              = format("%s-%s-%s-%s-%s", var.deployment_id, "route-public", var.env, var.locationcode, "01")
  private-route-table-name             = format("%s-%s-%s-%s-%s", var.deployment_id, "route-private", var.env, var.locationcode, "01")
  log_1_name                           = format("%s-%s-%s-%s-%s", var.deployment_id, "vpc-logs", var.env, var.locationcode, "01")
  flow-log-name                        = format("%s-%s-%s-%s-%s", var.deployment_id, "vpc-flow-logs", var.env, var.locationcode, "01")

  public-subnet-1-tags = {
    "Name"              = format("%s-%s-%s-%s-%s", var.deployment_id,"snt-public", var.env, var.locationcode, "01")
  }
  public-subnet-2-tags = {
    "Name"              = format("%s-%s-%s-%s-%s", var.deployment_id, "snt-public", var.env, var.locationcode, "02")
  }

   private-subnet-1-tags = {
    "Name"              = format("%s-%s-%s-%s-%s", var.deployment_id, "snt-private", var.env, var.locationcode, "01")
  }

   private-subnet-2-tags = {
    "Name"              = format("%s-%s-%s-%s-%s", var.deployment_id, "snt-private", var.env, var.locationcode, "02")
  }
  vpc_tags = {
    Name = format("%s-%s-%s-%s-%s", var.deployment_id, "vpc", var.env, var.locationcode, "01")
  }
  default_tags = {
      createdBy   =      var.created_by
      app_module  =      var.app_module
  }
}


module "vpc" {
  source        = "../../components/networking/vpc"
  cidrange      = var.cidrange
  tags          = merge (local.vpc_tags,local.default_tags)
  gateway_tags  = merge ({"Name": local.gateway_name},local.default_tags )
}

module "public_subnet_1" {
  source                  = "../../components/networking/subnets"
  tags                    = merge(local.public-subnet-1-tags, local.default_tags)
  vpc_id                  = module.vpc.vpc_id
  subnet-block            = var.public-subnet-1-block
  az                      = var.az1
  map-public-ip-on-launch = true
}

module "public_subnet_2" {
  source                  = "../../components/networking/subnets"
  tags                    = merge(local.public-subnet-2-tags, local.default_tags)
  vpc_id                  = module.vpc.vpc_id
  subnet-block            = var.public-subnet-2-block
  az                      = var.az2
  map-public-ip-on-launch = true
}

module "private_subnet_1" {
  source                  = "../../components/networking/subnets"
  tags                    = merge(local.private-subnet-1-tags,local.default_tags )
  vpc_id                  = module.vpc.vpc_id
  subnet-block            = var.private-subnet-1-block
  az                      = var.az1
  map-public-ip-on-launch = true
}

module "private_subnet_2" {
  source                  = "../../components/networking/subnets"
  tags                    = merge(local.private-subnet-2-tags,local.default_tags )
  vpc_id                  = module.vpc.vpc_id
  subnet-block            = var.private-subnet-2-block
  az                      = var.az2
  map-public-ip-on-launch = true
}


module "nat_gateway_1" {
  source        = "../../components/networking/nat_gateway"
  subnet-id     = module.public_subnet_1.subnet_id
  tags  = merge ({"Name": local.nat-1-name},local.default_tags )
  
}

module "nat_gateway_2" {
  source        = "../../components/networking/nat_gateway"
  subnet-id     = module.public_subnet_2.subnet_id
  tags  = merge ({"Name": local.nat-2-name},local.default_tags )
}


module "nacl_public" {
  source        = "../../components/networking/nacl"
  vpc-id        = module.vpc.vpc_id
  subnet-ids    = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
  
  tags  = merge ({"Name": local.public-nacl-name},local.default_tags )
}

module "nacl_private_instance" {
  source        = "../../components/networking/nacl"
  vpc-id        = module.vpc.vpc_id
  subnet-ids    = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id]
  tags  = merge ({"Name": local.private-nacl-name},local.default_tags )
}

module "public_route_table" {
  source                  = "../../components/networking/route_table_public"
  vpc-id                  = module.vpc.vpc_id
  internet-gateway-id     = module.vpc.internet_gateway_id

  tags  = merge ({"Name": local.public-route-table-name},local.default_tags )
}

module "public_route_table_association" {
  source         = "../../components/networking/route_table_association"
  subnet-ids     = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
  route-table-id = module.public_route_table.route_table_id
}

module "private_route_table" {
  source                   = "../../components/networking/route_table_private"
  vpc-id                   = module.vpc.vpc_id
  nat-gateway-id           = module.nat_gateway_1.nat-id
  tags  = merge ({"Name": local.private-route-table-name},local.default_tags )
}

module "private_route_table_association" {
  source         = "../../components/networking/route_table_association"
  subnet-ids     = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id ]
  route-table-id = module.private_route_table.route_table_id
}


#creating vpc log bucket

module "logs_1_bucket" {
  # count                      = var.enable-vpc-logs ? 1 : 0
  source                     = "../../components/s3"
  bucket_name = local.log_1_name
  tags  = local.default_tags
  enable-deletion-protection = var.enable-deletion-protection
}

module "flow_log" {
  count         = var.enable-vpc-logs ? 1 : 0
  source        = "../../components/flow_logs"
  s3-arn        = module.logs_1_bucket.s3_arn
  traffic-type  = var.flow-log-traffic-type
  vpc-id        = module.vpc.vpc_id
  tags  = merge ({"Name": local.flow-log-name},local.default_tags )
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
