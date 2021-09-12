variable "enable-deletion-protection" {
  description = "Deletion Protection"
}

variable "policy" {
  description = "Bucket Policy"
  default     = null
}

variable "tags" {
  default = {
   "Created_By" = "Terraform"
  }
}

variable "bucket_name" {
  description = "Bucket name"
}