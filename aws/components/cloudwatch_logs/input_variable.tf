variable "name" {
  description = "Log Group Name"
}

variable "retention_in_days"{
  description = "retention period"
  default = "60"
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

variable "deployment-id" {
  description = "Deployment id"
}