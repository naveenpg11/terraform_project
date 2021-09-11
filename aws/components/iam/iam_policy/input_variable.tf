variable "resource_count" {
  description = "count of the resource to be created"
  default = 1
}

variable "name" {
  description = "policy name"
}

variable "policy" {
  description = "policy created"
}

variable "description" {
  description = "policy description"
}

variable "iam_role" {
  description = "iam role"
  default = ""
}
variable "group_name" {
  description = "Group name"
  default = ""
}


