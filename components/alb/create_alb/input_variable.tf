variable "alb-name" {
  description = "ALB Name"
}

variable "internal" {
  description = "Internal - True/False"
}


variable "security-group" {
  type        = list(any)
  description = "Security Group ID"
}

variable "public-subnets" {
  type        = list(any)
  description = "List of Public Subnet IDs"
}
variable "s3-name" {
  description = "S3 for access logs"
}

variable "access-logs-enabled" {
  description = "Flag to enable access logs"
}


variable "enable-deletion-protection" {
  description = "Deletion Protection"
}


variable "tags" {
  default = {
   "Created_By" = "Terraform"
  }
}