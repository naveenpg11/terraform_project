variable "public-subnet-1-id" {
  description = "public subnet 1 id"
}

variable "public-subnet-2-id" {
  description = "public subnet 2 id"
}

variable "wayne-subnet-1-id" {
  description = "inventory subnet1 id"
}

variable "wayne-subnet-2-id" {
  description = "inventory subnet2 id"
}

variable "redshift-subnet-1-id" {
  description = "inventory subnet1 id"
}

variable "redshift-subnet-2-id" {
  description = "inventory subnet2 id"
}

variable "msk-subnet-ids" {
  type        = list(any)
  description = "Subnet IDs List"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "elk-subnet-1-id" {
  description = "instance subnet1 id"
}

variable "enable-vpn" {
  description = "Enable VPN flag"
}

variable "elk-subnet-2-id" {
  description = "instance subnet2 id"
}

variable "alb-arn" {
  description = "alb arn"
}

variable "cidrange" {
  description = "set cidr "
}

variable "az1" {
  description = "az1"
}

variable "az2" {
  description = "az2"
}


variable "madstack-keypair-name" {
  description = "Keypair"
}

variable "client" {
  description = "Client"
}

variable "redshift-database-name" {
  description = "Redshift Database Name"
}

variable "redshift-username" {
  description = "Redshift Username"
}

variable "msk-instance-type" {
  description = "Instance Type"
}


variable "msd-orch-instance-type" {
  description = "Instance Type"
}

variable "msd-registry-instance-type" {
  description = "Instance Type"
}

variable "monitoring-instance-type" {
  description = "Instance Type"
}

variable "xblox-instance-type" {
  description = "Instance Type"
}

variable "vpn_dns_server" {
  description = "DNS Server"
}

variable "xblox-gpu-instance-type" {
  description = "Instance Type"
}

variable "batman-instance-type" {
  description = "Instance Type"
}

variable "senseblox-instance-type" {
  description = "Instance Type"
}

variable "logstash-instance-type" {
  description = "Instance Type"
}

variable "env" {
  description = "Environment"
}


variable "locationcode" {
  description = "Location Accronym. Used to comply naming convention"
}

variable "appcode" {
  description = "APPCODE"
  default     = "bi"
}

variable "eks_subnet_1_id" {
  description = "eks subnet1 id"
}
variable "enable-deletion-protection" {
  description = "Deletion Protection"
}

variable "eks_subnet_2_id" {
  description = "eks subnet2 id"
}

variable "access_id" {
  description = "access_id"
}

variable "access_key" {
  description = "access_key"
}

variable "disk-size" {
  description = "Disk_size"
}

variable "instance-image" {
  description = "Ami to be used for ec2"
}


variable "appowner" {
  description = "Application Owner"
}

variable "environment" {
  description = "Environment"
}

variable "aws_account_id" {
  description = "set the aws account id "
}

variable "region" {
  description = "Region"
}

variable "enable-cloudwatch" {
  description = "Flag to enable cloudwatch"
}

variable "enable_eks_logging" {
  description = "enable_eks_logging"
}

variable "enable_rds_logging" {
  description = "enable_rds_logging"
}

variable "backup_enabled" {
  description = "Backup enabled"
}

variable "vpn-security-group-id" {
  description = "VPN Security Group"
}
variable "deployment-id" {
  description = "Deployment id"
}
