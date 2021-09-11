variable "region" {
  description = "Region"
}

// Naming Convention Variables
variable "client" {
  description = "Client"
}

variable "env" {
  description = "Environment"
}

variable "locationcode" {
  description = "Location Accronym. Used to comply naming convention"
  type        = map(any)
  default = {
    us-east-1  = "use"
    us-west-2  = "usw"
    ap-south-1 = "aps"
    us-east-2 = "use2"
  }
}

variable "search-record-blog" {
  description = "Solr Record Blog"
}

variable "api-record-blog" {
  description = "Api Record Blog"
}

variable "logs-record-blog" {
  description = "Logs Record Blog"
}

variable "notify-record-blog" {
  description = "Notify Record Blog"
}

variable "monitor-record-blog" {
  description = "Monitot Record Blog"
}
variable "cd-record-blog" {
  description = "CD Record Blog"
}

variable "enable-vpc-logs" {
  description = "Flag to enable VPC flow logs"
}

variable "enable-alb-logs" {
  description = "Flag to enable ALB Access logs"
}


variable "vpc_create" {
  description = "Enter VPC ID if you have exisiting id, true if you want to create one"
}

variable "vpc-name" {
  description = "vpc name"
}

variable "vpc_id" {
  description = "existing VPC id"
}

variable "access_id" {
  description = "access_id"
}

variable "access_key" {
  description = "access_key"
}

variable "docker_server" {
  description = "set the docker repo name"
}
variable "docker_username" {
  description = "set the docker docker username"
}
variable "docker_password" {
  description = "set the docker password "
}
variable "aws_account_id" {
  description = "set the aws account id "
}

variable "cidrange" {
  description = "set the cidr range for vpc "
}

variable "gateway_id" {
  description = "existing gateway id"
}


variable "az1" {
  description = "availability zone 1"
}

variable "az2" {
  description = "availability zone 2"
}


variable "public-subnet-1-block" {
  description = "public subnet 1 cidr"
}

variable "public-subnet-2-block" {
  description = "public subnet 2 cidr"
}

variable "enable-vpn" {
  description = "Enable VPN"
}
variable "enable-deletion-protection" {
  description = "Deletion Protection"
}

variable "initvm-log-s3" {
  description = "Init VM log s3"
}



variable "madstack-keypair-name" {
  description = "Key Pair Name"
}

variable "vpn-ip" {
  description = "VPN IP"
}



variable "private-subnet-1-block" {
  description = "private subnet 1 cidr"
}


variable "private-subnet-2-block" {
  description = "private subnet 2 cidr"
}



variable "elasticache-node-type" {
  description = "cache node type"
}
variable "elk-disk-size" {
  description = "Disk_size"
}

variable "solr-disk-size" {
  description = "Disk_size"
}

variable "public_subnet1_create" {
  description = "Enter subnet ID if you have exisiting id, true if you want to create one"
}

variable "public_subnet2_create" {
  description = "Enter subnet ID if you have exisiting id, true if you want to create one"
}

variable "private_subnet1_create" {
  description = "Enter subnet ID if you have exisiting id, true if you want to create one"
}

variable "private_subnet2_create" {
  description = "Enter subnet ID if you have exisiting id, true if you want to create one"
}


variable "enable_cache_backup" {
  description = "If backup is enabled or not"
}


variable "appowner" {
  description = "Application Owner"
}

variable "environment" {
  description = "Tagging Environment"
}

variable "enable-cloudwatch" {
  description = "Flag to enable cloudwatch"
}

variable "redshift-username" {
  description = "Redshift Username"
}

variable "es-instance-type" {
  description = "ES Instance Type"
}

variable "xblox-es-instance-type" {
  description = "Xblox ES Instance type"
}

variable "msk-instance-type" {
  description = "Instance Type"
}

variable "msk-instance-type-xblox" {
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

variable "redshift-tablename" {
  description = "Redshift Table Name"
}

variable "vpn_dns_server" {
  description = "DNS Server"
}

variable "redshift-database-name" {
  description = "Redshift Database Name"
}

variable "enable_eks_logging" {
  description = "enable_eks_logging"
}

variable "enable_rds_logging" {
  description = "enable_rds_logging"
}

variable "enable_es_logging" {
  description = "enable_eks_logging"
}

variable "aws_backup_enabled" {
  description = "AWS backup enabled"
}


variable "es-master-enabled" {
  description = "Master Enabled"
}

variable "es-master-type" {
  description = "Master Type"
}

variable "es-master-count" {
  description = "Master Count"
}

variable "es-warm-enabled" {
  description = "Warm Enabled"
}


variable "es-warm-count" {
  description = "Warm Count"
}

variable "es-warm-type" {
  description = "Warm Type"
}

variable "xblox-kibana-record-blog" {
  description = "Xblox Kibana Record Blog"
}

variable "deployment-id" {
  description = "Deployment id"
}


variable "container-image-id" {
  description = "Container IMage ID"
}