locals {

security-group-name = format("%s-%s-%s-%s-%s",var.deployment_id, "ecs_sg",var.env, var.locationcode, "01")
launch_config = format("%s-%s-%s-%s-%s", var.deployment_id, "launch_config", var.env, var.locationcode, "01")
ecs_autoscaling_group = format("%s-%s-%s-%s-%s", var.deployment_id, "ecs-asg", var.env, var.locationcode, "01")
capacity_provider_ecs = format("%s-%s-%s-%s-%s", var.deployment_id, "ecs-cpacity", var.env, var.locationcode, "01")
ecs_service = format("%s-%s-%s-%s-%s", var.deployment_id, "ecs-service", var.env, var.locationcode, "01")
container_name = "container-api"
default_tags ={
  createdBy = var.created_by
  app_module = var.app_module
}
}


module "launch_config_sg_ecs" {
  source              = "../../components/networking/security_group"
  security-group-name = local.security-group-name
  vpc_id              = var.vpc_id
  tags                = local.default_tags
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
  name = local.launch_config
  launch_template_sg = module.launch_config_sg_ecs.security_group_id
}

module "auto_scaling_group"{
  source = "../../components/autoscaling_group"
  name = local.ecs_autoscaling_group
  launch_template_ecs = module.ecs_launch_config.name
  min_count = 1
  max_count = 1
  desired_count = 1
  private_subnet_1_id = var.private_subnet_1_id
  private_subnet_2_id = var.private_subnet_2_id
  tags                = local.default_tags
  depends_on = [module.ecs_launch_config]
}

module "ecs_capacity_provider" {
  source = "../../components/ecs/capacity_provider"
  name = local.capacity_provider_ecs
  auto_scaling_group_arn = module.auto_scaling_group.asg_arn

  depends_on = [module.auto_scaling_group]
}

module "ecs_cluster" {
  source = "../../components/ecs/ecs"
  name = "base_cluster"
  capacity_provider = module.ecs_capacity_provider.name

  tags  = local.default_tags
}

module "ecs_task_definition" {
  source = "../../components/ecs/task_definition_ec2"
  container_name             = local.container_name
  container_image_id         = var.container_image_id
}

module "ecs_service" {
  source = "../../components/ecs/service_ec2"
  name = local.ecs_service
  cluster_id = module.ecs_cluster.id
  container_task_def_arn = module.ecs_task_definition.id
  desired_count   = 1
  target_group_arn = var.target_group_arn
  container_name = "container-api"
  container_port = var.application_container_port
  depends_on = [module.auto_scaling_group, module.ecs_cluster]
}
