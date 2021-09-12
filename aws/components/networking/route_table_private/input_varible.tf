variable "vpc-id" {
  description = "VPC ID"
}

variable "nat-gateway-id" {
  description = "NAT Gatway ID"
}

variable "tags" {
  default = {
   "Created_By" = "Terraform"
  }
}


