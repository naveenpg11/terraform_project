variable "trail-name" {
  description = "Trail Name"
}

variable "s3-name" {
  description = "S3 Name"
}

variable "cloudwatch-arn" {
  description = "Cloudwatch Arn"
  default     = null
}

variable "appname" {
  description = "Application"
}

variable "appowner" {
  description = "Application Owner"
}

variable "environment" {
  description = "Environment"
}

variable "approle" {
  description = "Application Role"
}


variable "cloudwatch-role-arn" {
  description = "CloudWatch Role ARN"
  default     = null
}

variable "deployment-id" {
  description = "Deployment id"
}