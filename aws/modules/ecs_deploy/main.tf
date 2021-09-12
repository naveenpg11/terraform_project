locals {
appname =  "appname"
appowner =  "naveen"
environment = "dev"
deployment-id = "asdad"
approle = "vsd"
security-group-name = "launch_config_sg"
}

module "launch_config_sg_ecs" {
  source              = "../../components/networking/security_group"
  security-group-name = local.security-group-name
  vpc_id              = var.vpc_id
  appname             = local.appname
  appowner            = local.appowner
  environment         = local.environment
  deployment-id       = local.deployment-id
  approle             = local.approle
}

module "launch_config_sg_ecs_rule" {
  source            = "../../components/networking/security_group_rules"
  type              = "ingress"
  from-port         = 0
  to-port           = 0
  protocol          = "-1"
  cidr-blocks       = [var.vpc_cidr_block]
  security-group-id = module.launch_config_sg_ecs.security_group_id
  description       = "launch_config_sg_ecs_rule"
}


module "ecs_launch_config" {
  source = "../../components/ecs/launch_templates"
  name = "ecs_launch_template"
  launch_template_sg = module.launch_config_sg_ecs.security_group_id
}

module "auto_scaling_group"{
  source = "../../components/autoscaling_group"
  name = "ecs_autoscaling_group"
  launch_template_ecs = module.ecs_launch_config.name
  min_count = 1
  max_count = 1
  desired_count = 1
  private_subnet_1_id = var.private_subnet_1_id
  private_subnet_2_id = var.private_subnet_2_id

  depends_on = [module.ecs_launch_config]
}

module "ecs_capacity_provider" {
  source = "../../components/ecs/capacity_provider"
  name = "capacity_provider_ecs"
  auto_scaling_group_arn = module.auto_scaling_group.asg_arn
}

module "ecs_cluster" {
  source = "../../components/ecs/ecs"
  name = "base_cluster"
  capacity_provider = module.ecs_capacity_provider.name


}

module "ecs_service" {
  source = "../../components/ecs/service_ec2"
  name = "Ecs_service"
  cluster_id = module.ecs_cluster.id
  container_task_def_arn = var.container_task_def_arn
  desired_count   = 1
  target_group_arn = var.target_group_arn
  container_name = "container-api"
  container_port = 8000

  depends_on = [module.auto_scaling_group, module.ecs_cluster]
}
