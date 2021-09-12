variable "target-group-name" {
  description = "Name of Target Group"
}

variable "port" {
  description = "Port of Target Group"
}

variable "protocol" {
  description = "Protocol for target group"
}

variable "vpc-id" {
  description = "VPC ID"
}

variable "health-check-protocol" {
  description = "Health Check protocol"
}

variable "health-check-path" {
  description = "Health Check Path"
}

variable "health-check-port" {
  description = "Health Check port"
}

variable "healthy-threshold" {
  description = "Healthy Threshold"
}

variable "unhealthy-threshold" {
  description = "Unhealthy Threshold"
}


variable "health-check-timeout" {
  description = "Health Check Timeout"
}

variable "health-check-interval" {
  description = "Health Check Interval"
}

variable "health-check-matcher" {
  description = "Health Check Matcher"
}
variable "tags" {
  default = {
   "Created_By" = "Terraform"
  }
}