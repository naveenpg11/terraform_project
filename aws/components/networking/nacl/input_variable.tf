variable "vpc-id" {
  description = "vpc"
}

variable "nacl-name" {
  description = "nacl name"
}

variable "subnet-ids" {
  type = list
  description = "Subnet IDS"
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