variable "private_subnet_1_id" {
  description = "private_subnet_1_id  id"
}


variable "private_subnet_2_id" {
  description = "private_subnet_2_id  id"
}


variable "vpc_cidr_block" {
  description = "vpc cidr block"
}


variable "vpc_id" {
  description = "existing VPC id"
}


variable "target_group_arn" {
  description = "ALB's TargerGroup ARN"
}

variable "created_by"{
    description = "Pls specify the user"
    default = "unknown"
}

variable "container_image_id" {
  description = "Container Image ID"
}

variable "app_module"{
    default = "ecs_deploy"
}

variable "locationcode" {
  description = "Enter locationcode"
}

variable "env" {
  description = "Enter env"
}

variable "deployment_id" {
  description = "Enter deployment-id"
}

variable "application_container_port" {
  description = "Application_container_port"
}