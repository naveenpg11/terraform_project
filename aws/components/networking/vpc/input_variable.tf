variable "vpc_create" {
  description = "Enter existing vpc id or 'true' to create a new VPC"
}

variable "cidrange" {
  description = "cidr range for the VPC to be created"
}

variable "vpc-name" {
  description = "Name of vpc"
}

variable "gateway_id" {
  description = "Existing gateway id"
}

variable "gateway-name" {
  description = "Gateway Name"
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