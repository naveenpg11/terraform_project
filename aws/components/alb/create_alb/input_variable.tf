variable "alb-name" {
  description = "ALB Name"
}

variable "security-group" {
  type        = list(any)
  description = "Security Group ID"
}

variable "public-subnets" {
  type        = list(any)
  description = "List of Public Subnet IDs"
}

variable "appname" {
  description = "Application"
}

variable "appowner" {
  description = "Application Owner"
}

variable "s3-name" {
  description = "S3 for access logs"
}

variable "access-logs-enabled" {
  description = "Flag to enable access logs"
}


variable "environment" {
  description = "Environment"
}

variable "approle" {
  description = "Application Role"
}

variable "deployment-id" {
  description = "Deployment id"
}

variable "enable-deletion-protection" {
  description = "Deletion Protection"
}
