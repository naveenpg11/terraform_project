variable "vpc_id" {
  description = "Enter vpc ID"
}

variable "vpc_cidr_block" {
  description = "vpc's cidr block for SG restriction"
}


variable "private_subnet_1_id" {
  description = "Enter private_subnet_1_id"
}
variable "private_subnet_2_id" {
  description = "Enter private_subnet_2_id"
}

variable "env" {
  description = "Enter env"
}
variable "locationcode" {
  description = "Enter locationcode"
}

variable "deployment_id" {
  description = "Enter deployment-id"
}
variable "enable-deletion-protection" {
  description = "Enter enable-deletion-protection True/ False"
}

variable "enable-alb-logs" {
  description = "Enter enable-alb-logs True/False"
}

variable "tg-port" {
  default = 8000
  description = "Target group port"
}

variable "tg-protocol" {
  default = "HTTP"
}

variable "listener-port" {
  default = 80
}

variable "listener-protocol" {
  default = "HTTP"
}


variable "health-check-protocol" {
  default = "HTTP"
}

variable "health-check-path" {
  default = "/api/emails/"
}

variable "health-check-port" {
  default = 8000
}

variable "healthy-threshold" {
  default = 5
}

variable "unhealthy-threshold" {
  default = 2
}


variable "health-check-timeout" {
  default = 5
}

variable "health-check-interval" {
  default = 30
}

variable "health-check-matcher" {
  default = 200
}

variable "created_by"{
    description = "Pls specify the user"
    default = "unknown"
}

variable "app_module"{
    default = "load_balancer"
}