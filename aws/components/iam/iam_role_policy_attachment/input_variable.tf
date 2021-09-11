variable "resource_count" {
  description = "count of the resource to be created"
  default = 1
}

variable "iam_role" {
  description = "role arn"
}

variable "policy_arn" {
  description = "policy arn"
}