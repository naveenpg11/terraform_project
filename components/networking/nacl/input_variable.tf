variable "vpc-id" {
  description = "vpc"
}

variable "subnet-ids" {
  type = list
  description = "Subnet IDS"
}

variable "tags" {
  default = {
   "Created_By" = "Terraform"
  }
}