variable "created_by" {
  description = "Resource CreatedBy"
}
variable "app_module" {
  default = "Networks"
}

variable "deployment_id" {
  description = "Deployment id"
}



variable "enable-vpc-logs" {
  description = "Flag to enable VPC flow logs"
}

variable "env" {
  description = "Environment"
}


variable "locationcode" {
  description = "Location Accronym. Used to comply naming convention"
}

variable "flow-log-traffic-type" {
  default     = "ALL"
  description = "Flow Logs Traffic type"
}

variable "cidrange" {
  description = "Cidr Range"
}

variable "public-subnet-1-block" {
  description = "Public subnet 2 block"
}

variable "public-subnet-2-block" {
  description = "Public subnet 2 block"
}

variable "private-subnet-1-block" {
  description = "private subnet 1 block"
}

variable "private-subnet-2-block" {
  description = "private subnet 2 block"
}
variable "az1" {
  description = "Availability Zone 1"
}

variable "az2" {
  description = "Availability Zone 2"
}


variable "enable-deletion-protection" {
  description = "enable-deletion-protection"
}


