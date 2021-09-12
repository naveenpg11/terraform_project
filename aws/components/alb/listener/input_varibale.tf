variable "lb-arn" {
  description = "ARN of ALB"
}

variable "port" {
  description = "Port for listening"
}

variable "protocol" {
  description = "Protocol for listener"
}

variable "target-group-arn" {
  description = "ARN of target group"
}