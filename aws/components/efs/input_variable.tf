
variable "efs-name" {
  description = "EFS Name"
}

variable "appname" {
  description = "Application"
}

variable "appowner" {
  description = "Application Owner"
}

variable "sgs" {
  description = "Security Group IDs"
  type        = list(any)
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

variable "subnets" {
  description = "List of Subnets IDS"
  type        = list(string)
}
