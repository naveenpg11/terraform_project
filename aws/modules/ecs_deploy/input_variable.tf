# variable "public_subnet_1_id" {
#   description = "public_subnet_1_id  id"
# }


# variable "public_subnet_2_id" {
#   description = "public_subnet_1_id  id"
# }

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


variable "container_task_def_arn" {
    description = "Task container definitions's ARN"
}