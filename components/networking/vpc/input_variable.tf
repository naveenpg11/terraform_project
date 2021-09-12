
variable "cidrange" {
  description = "cidr range for the VPC to be created"
}

variable "tags" {
  default = {
   "Created_By" = "Terraform"
  }
}

variable "gateway_tags" {
  default = {
   "Created_By" = "Terraform"
  }
}