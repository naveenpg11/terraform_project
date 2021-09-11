terraform {
  required_providers {
    aws = {
      version = "~> 3.24.1"
    }
    null = {
      version = "2.1"
    }
  }
  # backend "s3" {
  #   bucket = "iac-madstack-1"
  #   key    = "<<date>>/terraform.tfstate"
  #   region = "ap-south-1"
  # }
}

provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu-18_04" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

module "vpc" {
  source                     = "./modules/global/networking"
  vpc_create                 = var.vpc_create
  cidrange                   = var.cidrange
  gateway_id                 = var.gateway_id
  public-subnet-1-block      = var.public-subnet-1-block
  public-subnet-2-block      = var.public-subnet-2-block

  private-subnet-1-block      = var.private-subnet-1-block
  private-subnet-2-block      = var.private-subnet-2-block


  az1                        = var.az1
  az2                        = var.az2
  client                     = var.client
  env                        = var.env
  locationcode               = lookup(var.locationcode, var.region)

  public_subnet1_create      = var.public_subnet1_create
  public_subnet2_create      = var.public_subnet2_create
  
  private_subnet1_create      = var.private_subnet1_create
  private_subnet2_create      = var.private_subnet2_create


  appowner                   = var.appowner
  environment                = var.environment
  deployment-id              = var.deployment-id
  region                     = var.region
  enable-deletion-protection = var.enable-deletion-protection
  aws_account_id             = var.aws_account_id
  enable-vpc-logs            = var.enable-vpc-logs
  enable-alb-logs            = var.enable-alb-logs
  vpn-ip                     = var.vpn-ip
}


module "container-task-def" {
  source                     = "./modules/global/ecs"
  container-image-id         = var.container-image-id
}

module "ecs_service" {
  source       = "./modules/ecs_deploy"
  vpc_id       = module.vpc.vpc_id
  private_subnet_1_id         = module.vpc.private_subnet_1_id
  private_subnet_2_id         = module.vpc.private_subnet_2_id
  target_group_arn           = module.vpc.target_group_arn
  container_task_def_arn     = module.container-task-def.task_definition_id

  depends_on = [module.vpc]
}
module "expose_api_https" {
  source = "./modules/gateway_http_proxy"
  lb_dns_name = module.vpc.alb-dns_name
}

module "expose_api_https_private" {
  source = "./modules/gateway_https_private"
  vpc_id       = module.vpc.vpc_id
  private_subnet_1_id         = module.vpc.private_subnet_1_id
  private_subnet_2_id         = module.vpc.private_subnet_2_id
  alb_listener_arn            = module.vpc.alb_listener_arn
}

# }


# module "route53" {
#   source                   = "./modules/global/route53"
#   vpc-id                   = module.vpc.vpc_id
#   appowner                 = var.appowner
#   environment              = var.environment
#   deployment-id            = var.deployment-id
#   client                   = var.client
#   env                      = var.env
#   solr-record-blog         = var.search-record-blog
#   solr-lb-dns              = module.vpc.alb-dns_name
#   solr-lb-zone-id          = module.vpc.alb-zone-id
#   kibana-record-blog       = var.logs-record-blog
#   kibana-dns               = module.search.kibana_endpoint
#   xblox-kibana-record-blog = var.xblox-kibana-record-blog
#   xblox-kibana-dns         = module.xblox.kibana_endpoint
# }

# module "global" {
#   source                     = "./modules/global"
#   vpc_id                     = module.vpc.vpc_id
#   eks_subnet_1_id            = module.vpc.eks_subnet_1_id
#   eks_subnet_2_id            = module.vpc.eks_subnet_2_id
#   public-subnet-1-id         = module.vpc.public_subnet_1_id
#   wayne-subnet-1-id          = module.vpc.inventory_subnet_1_id
#   wayne-subnet-2-id          = module.vpc.inventory_subnet_2_id
#   redshift-subnet-1-id       = module.vpc.inventory_subnet_1_id
#   redshift-subnet-2-id       = module.vpc.inventory_subnet_2_id
#   msk-subnet-ids             = [module.vpc.msk_subnet_1_id, module.vpc.msk_subnet_2_id]
#   public-subnet-2-id         = module.vpc.public_subnet_2_id
#   elk-subnet-1-id            = module.vpc.instance_subnet_1_id
#   elk-subnet-2-id            = module.vpc.instance_subnet_2_id
#   alb-arn                    = module.vpc.alb-arn
#   az1                        = var.az1
#   az2                        = var.az2
#   madstack-keypair-name      = var.madstack-keypair-name
#   cidrange                   = var.cidrange
#   disk-size                  = var.elk-disk-size
#   instance-image             = data.aws_ami.ubuntu-18_04.id
#   depends_on                 = [module.vpc]
#   client                     = var.client
#   env                        = var.env
#   locationcode               = lookup(var.locationcode, var.region)
#   appowner                   = var.appowner
#   aws_account_id             = var.aws_account_id
#   environment                = var.environment
#   deployment-id              = var.deployment-id
#   region                     = var.region
#   access_id                  = var.access_id
#   access_key                 = var.access_key
#   enable-vpn                 = var.enable-vpn
#   enable-cloudwatch          = var.enable-cloudwatch
#   enable-deletion-protection = var.enable-deletion-protection
#   redshift-username          = var.redshift-username
#   redshift-database-name     = var.redshift-database-name
#   enable_eks_logging         = var.enable_eks_logging
#   enable_rds_logging         = var.enable_rds_logging
#   msk-instance-type          = var.msk-instance-type
#   msd-orch-instance-type     = var.msd-orch-instance-type
#   msd-registry-instance-type = var.msd-registry-instance-type
#   monitoring-instance-type   = var.monitoring-instance-type
#   xblox-instance-type        = var.xblox-instance-type
#   xblox-gpu-instance-type    = var.xblox-gpu-instance-type
#   batman-instance-type       = var.batman-instance-type
#   senseblox-instance-type    = var.senseblox-instance-type
#   logstash-instance-type     = var.logstash-instance-type
#   vpn_dns_server             = var.vpn_dns_server
#   backup_enabled             = var.aws_backup_enabled
#   vpn-security-group-id      = module.vpc.vpn_security_group_id
# }

# module "mpl" {
#   source                     = "./modules/metadata_pipeline"
#   vpc-id                     = module.vpc.vpc_id
#   public-subnet-1-id         = module.vpc.public_subnet_1_id
#   public-subnet-2-id         = module.vpc.public_subnet_2_id
#   solr-subnet-1-id           = module.vpc.instance_subnet_1_id
#   solr-subnet-2-id           = module.vpc.instance_subnet_2_id
#   ansible-publicip           = module.global.ansible-publicip
#   alb-arn                    = module.vpc.alb-arn
#   az1                        = var.az1
#   az2                        = var.az2
#   keypair-name               = module.global.keypair_name
#   cidrange                   = var.cidrange
#   client                     = var.client
#   env                        = var.env
#   locationcode               = lookup(var.locationcode, var.region)
#   disk-size                  = var.solr-disk-size
#   instance-image             = data.aws_ami.ubuntu-18_04.id
#   depends_on                 = [module.vpc]
#   appowner                   = var.appowner
#   environment                = var.environment
#   deployment-id              = var.deployment-id
#   watchtower-subnet-1-id     = module.vpc.inventory_subnet_1_id
#   watchtower-subnet-2-id     = module.vpc.inventory_subnet_2_id
#   enable-deletion-protection = var.enable-deletion-protection
#   ansible-sg                 = module.global.ansible-sg-id
#   eks-sg-id                  = module.global.eks-sg-id
#   alb-sg-id                  = module.vpc.alb-sg-id
#   region                     = var.region
#   enable_rds_logging         = var.enable_rds_logging
#   backup_enabled             = var.aws_backup_enabled
#   vpn-security-group-id      = module.vpc.vpn_security_group_id
# }

# module "epl" {
#   source                     = "./modules/events_pipeline"
#   subnet_ids                 = [module.vpc.inventory_subnet_1_id, module.vpc.inventory_subnet_2_id]
#   elasticache-node-type      = var.elasticache-node-type
#   vpc_id                     = module.vpc.vpc_id
#   depends_on                 = [module.vpc]
#   client                     = var.client
#   env                        = var.env
#   locationcode               = lookup(var.locationcode, var.region)
#   appowner                   = var.appowner
#   environment                = var.environment
#   deployment-id              = var.deployment-id
#   cidrange                   = var.cidrange
#   enable_backup              = var.enable_cache_backup
#   enable-deletion-protection = var.enable-deletion-protection
#   vpn-security-group-id      = module.vpc.vpn_security_group_id
# }

# module "search" {
#   source                     = "./modules/global/aws_elk"
#   client                     = var.client
#   env                        = var.env
#   locationcode               = lookup(var.locationcode, var.region)
#   subnet-ids                 = [module.vpc.instance_subnet_1_id, module.vpc.instance_subnet_2_id]
#   security-group-id          = module.vpc.logstash_security_group_id
#   keypair-name               = module.global.keypair_name
#   ansible-publicip           = module.global.ansible-publicip
#   appowner                   = var.appowner
#   environment                = var.environment
#   deployment-id              = var.deployment-id
#   instance-image             = data.aws_ami.ubuntu-18_04.id
#   vpc_id                     = module.vpc.vpc_id
#   cidrange                   = var.cidrange
#   bootstrap-servers          = module.global.bootstrap-servers
#   depends_on                 = [module.vpc]
#   enable-deletion-protection = var.enable-deletion-protection
#   backup_enabled             = var.aws_backup_enabled
#   enable_es_logging          = var.enable_es_logging
#   region                     = var.region
#   warm-enabled               = var.es-warm-enabled
#   warm-count                 = var.es-warm-count
#   warm-type                  = var.es-warm-type
#   master-enabled             = var.es-master-enabled
#   master-type                = var.es-master-type
#   master-count               = var.es-master-count
#   vpn-security-group-id      = module.vpc.vpn_security_group_id
#   instance-type              = var.es-instance-type
# }

# module "init_vm" {
#   source                     = "./modules/global/eks/init_vm"
#   vpc_id                     = module.vpc.vpc_id
#   eks_name                   = module.global.eks_name
#   psql_username              = module.global.psql_username
#   psql_host                  = module.global.psql_host
#   psql_dbname                = module.global.psql_dbname
#   psql_password              = module.global.psql_password
#   solr-alb-dns_name          = module.vpc.solr-alb-dns_name
#   security_group_id          = module.vpc.security_group_id
#   fluentd_s3_bucket          = module.global.bucket_name
#   esmasterip                 = module.search.esmasterip
#   logstaship                 = module.search.logstaship
#   zookeeperip1               = module.mpl.zookeeperip1
#   zookeeperip2               = module.mpl.zookeeperip2
#   zookeeperip3               = module.mpl.zookeeperip3
#   region                     = var.region
#   solrip1                    = module.mpl.solrip1
#   solrip2                    = module.mpl.solrip2
#   solrip3                    = module.mpl.solrip3
#   access_id                  = var.access_id
#   access_key                 = var.access_key
#   docker_server              = var.docker_server
#   docker_username            = var.docker_username
#   docker_password            = var.docker_password
#   aws_account_id             = var.aws_account_id
#   instance-image             = data.aws_ami.ubuntu-18_04.id
#   eks-subnet-1               = module.vpc.eks_subnet_1_id
#   client                     = var.client
#   env                        = var.env
#   locationcode               = lookup(var.locationcode, var.region)
#   depends_on                 = [module.vpc, module.global, module.mpl, module.search]
#   appowner                   = var.appowner
#   environment                = var.environment
#   deployment-id              = var.deployment-id
#   enable-deletion-protection = var.enable-deletion-protection
#   wayne_restapikey           = module.global.wayne_restapikey
#   initvm-log-s3              = var.initvm-log-s3
#   gcpd-redis-host            = module.senseblox.gcpd-redis-host
#   solrbk-bucket              = module.mpl.solrbk-bucket
#   eks-role-arn               = module.global.eks-role-arn
#   grafana-role-arn           = module.global.grafana-role-arn
#   vpn-security-group-id      = module.vpc.vpn_security_group_id
# }

# module "xblox" {
#   source                     = "./modules/xblox"
#   vpc_id                     = module.vpc.vpc_id
#   msk-subnet-ids             = [module.vpc.msk_subnet_1_id, module.vpc.msk_subnet_2_id]
#   security_group_id          = module.vpc.security_group_id
#   logstash-security-group-id = module.vpc.logstash_security_group_id
#   elasticache_subnet_ids     = [module.vpc.inventory_subnet_1_id, module.vpc.inventory_subnet_2_id]
#   elasticache-node-type      = var.elasticache-node-type
#   az1                        = var.az1
#   az2                        = var.az2
#   instance-image             = data.aws_ami.ubuntu-18_04.id
#   eks-subnet-1               = module.vpc.public_subnet_1_id
#   rds-subnet-1-id            = module.vpc.inventory_subnet_1_id
#   rds-subnet-2-id            = module.vpc.inventory_subnet_2_id
#   client                     = var.client
#   env                        = var.env
#   ansible-publicip           = module.global.ansible-publicip
#   locationcode               = lookup(var.locationcode, var.region)
#   eks_name                   = module.global.eks_name
#   access_id                  = var.access_id
#   access_key                 = var.access_key
#   region                     = var.region
#   depends_on                 = [module.vpc]
#   appowner                   = var.appowner
#   environment                = var.environment
#   deployment-id              = var.deployment-id
#   cidrange                   = var.cidrange
#   enable_backup              = var.enable_cache_backup
#   es-subnet-ids              = [module.vpc.instance_subnet_1_id, module.vpc.instance_subnet_2_id]
#   enable-deletion-protection = var.enable-deletion-protection
#   aws_account_id             = var.aws_account_id
#   initvm-log-s3              = var.initvm-log-s3
#   enable_es_logging          = var.enable_es_logging
#   backup_enabled             = var.aws_backup_enabled
#   depend-flag                = module.init_vm.depend-flag
#   msk-instance-type          = var.msk-instance-type-xblox
#   oidc-provider-arn          = module.global.oidc-provider-arn
#   wayne_restapikey           = module.global.wayne_restapikey
#   vpn-security-group-id      = module.vpc.vpn_security_group_id
#   warm-enabled               = var.es-warm-enabled
#   warm-count                 = var.es-warm-count
#   warm-type                  = var.es-warm-type
#   master-enabled             = var.es-master-enabled
#   master-type                = var.es-master-type
#   master-count               = var.es-master-count
#   es-instance-type           = var.xblox-es-instance-type
# }


# module "senseblox" {
#   source                     = "./modules/senseblox"
#   subnet_ids                 = [module.vpc.inventory_subnet_1_id, module.vpc.inventory_subnet_2_id]
#   elasticache-node-type      = var.elasticache-node-type
#   vpc_id                     = module.vpc.vpc_id
#   depends_on                 = [module.vpc]
#   client                     = var.client
#   env                        = var.env
#   locationcode               = lookup(var.locationcode, var.region)
#   appowner                   = var.appowner
#   environment                = var.environment
#   deployment-id              = var.deployment-id
#   cidrange                   = var.cidrange
#   eks_name                   = module.global.eks_name
#   access_id                  = var.access_id
#   access_key                 = var.access_key
#   region                     = var.region
#   security_group_id          = module.vpc.security_group_id
#   eks-subnet-1               = module.vpc.public_subnet_1_id
#   instance-image             = data.aws_ami.ubuntu-18_04.id
#   enable_backup              = var.enable_cache_backup
#   enable-deletion-protection = var.enable-deletion-protection
#   aws_account_id             = var.aws_account_id
#   initvm-log-s3              = var.initvm-log-s3
#   queue-url                  = module.global.queue-url
#   failure-queue-url          = module.global.failure-queue-url
#   redshift-username          = var.redshift-username
#   redshift-password          = module.global.redshift-password
#   redshift-database-name     = var.redshift-database-name
#   redshift-dns               = module.global.redshift-dns-name
#   efs-dns                    = module.global.efs-dns
#   wayne_restapikey           = module.global.wayne_restapikey
#   depend-flag                = module.init_vm.depend-flag
#   redshift-tablename         = var.redshift-tablename
#   vpn-security-group-id      = module.vpc.vpn_security_group_id
# }

# module "aws_backup" {
#   source         = "./modules/Backup"
#   client         = var.client
#   env            = var.env
#   locationcode   = lookup(var.locationcode, var.region)
#   backup_enabled = var.aws_backup_enabled
#   depends_on     = [module.init_vm, module.xblox, module.senseblox]
# }


