variable "s3-arn" {
  description = "S3 arn"
}

variable "vpc-id" {
  description = "VPC ID"
}

variable "traffic-type" {
  description = "Traffic Type"
}


variable "tags" {
  default = {
   "Created_By" = "Terraform"
  }
}