variable "name" {
    description = "description"
  }
variable "launch_template_ecs" {
    description = "Launch template ID"
  }

variable "min_count" {
    description = "min_count"
  }

variable "max_count" {
    description = "max_count"
  }
variable "desired_count" {
    description = "desired_count"
  }
variable "private_subnet_1_id" {
    description = "private_subnet_1_id"
  }
variable "private_subnet_2_id" {
    description = "private_subnet_2_id"
  }
  
variable "tags" {
  default = {
   "Created_By" = "Terraform"
  }
}