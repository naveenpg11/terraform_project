
variable "vpc-id" {
  description = "VPC ID"
}

variable "internet-gateway-id" {
  description = "Intenet Gatway ID"

}
variable "tags" {
  default = {
   "Created_By" = "Terraform"
  }
}