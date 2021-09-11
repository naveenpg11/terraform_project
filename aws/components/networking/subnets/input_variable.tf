variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet-block" {
  description = "Subnet Block"
}

variable "az" {
  description = "Avalability Zone"
}

variable "tags" {
  default = {
   "Created_By" = "Terraform"
  }
}

variable "map-public-ip-on-launch" {
  description = "Map Public IP on Launch"
}

variable "subnet_create"{
  description = "Enter existing subnet id or 'true' to create a new subnet"
}