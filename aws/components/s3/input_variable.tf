variable "bucket-name" {
  description = "Bucket Name"
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

variable "enable-deletion-protection" {
  description = "Deletion Protection"
}

variable "approle" {
  description = "Application Role"
}

variable "policy" {
  description = "Bucket Policy"
  default     = null
}
variable "deployment-id" {
  description = "Deployment id"
}