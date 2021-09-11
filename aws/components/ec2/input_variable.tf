variable "ec2-name" {
  description = "Name of the EC2 Instance"
}


variable "security-group-id" {
  type        = list(any)
  description = "ID of the Security Group"
}

variable "subnet-ids" {
  type        = list(any)
  description = "Subnet ID"
}

variable "iam_instance_profile" {
  description = "IAM Instance Profile"
  default     = null
}

variable "backup_enabled" {
  description = "Backup enabled"
  default     = false
}

variable "enable-deletion-protection" {
  description = "Deletion Protection"
  default     = false
}


variable "auto-shutdown" {
  description = "Autoshutdown"
  default     = null
}

variable "instance-image" {
  description = "Image Id of the instance image"
}

variable "instance-type" {
  description = "EC2 Instance type"
}


variable "ec2-instance-count" {
  description = "Count of instances to be created"
}

variable "user-data" {
  description = "Bootstrap Data"
}

variable "associate_public_ip_address" {
  description = "Need to associate a public ip with instance ?"
}

variable "keypair-name" {
  description = "Keypair Name"
}


variable "volume-size" {
  description = "Root block volume size"
}

variable "start-index" {
  description = "Starting Index of EC2 Name"
  default     = 1
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
