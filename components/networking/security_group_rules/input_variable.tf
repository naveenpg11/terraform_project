variable "type" {
  description = "Rule Type"
}

variable "from-port" {
  description = "From Port"
}

variable "to-port" {
  description = "To Port"
}

variable "protocol" {
  description = "Rule Protocol"
}

variable "cidr-blocks" {
  description = "Cidr Blocks"
  default = null
}

variable "security-group-id" {
  description = "Security Group ID"
}


variable "description" {
  description = "Description of Rule"
}

variable "source-sg" {
  description = "Source Security Group  SG"
  default     = null
}
