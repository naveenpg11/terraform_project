variable "vpc_create" {
  description = "Enter VPC ID if you have exisiting id, true if you want to create one"
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


variable "enable-vpc-logs" {
  description = "Flag to enable VPC flow logs"
}

variable "enable-alb-logs" {
  description = "Flag to enable ALB Access logs"
}

variable "enable-deletion-protection" {
  description = "Deletion Protection"
}

variable "vpc-name" {
  description = "vpc name"
  default     = "vpc"
}

variable "gateway-name" {
  description = "Gateway Name"
  default     = "ig"
}

variable "client" {
  description = "Client"
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


variable "pub-appcode" {
  description = "Public APPCODE"
  default     = "public"
}

variable "private-appcode" {
  description = "Public APPCODE"
  default     = "private"
}

variable "region" {
  description = "Region "
}

variable "endpoint-name" {
  default = "vpce"
}

variable "flow-log-traffic-type" {
  default     = "ALL"
  description = "Flow Logs Traffic type"
}

variable "flow-log-name" {
  description = "Flow Log Name"
  default     = "flog"
}

variable "aws_account_id" {
  description = "AWS Account ID"
}


variable "ins-appcode" {
  description = "Instance APPCODE"
  default     = "ec2"
}

variable "inv-appcode" {
  description = "Inventory APPCODE"
  default     = "inv"
}

variable "eks-appcode" {
  description = "EKS APPCODE"
  default     = "eks"
}

variable "msk-appcode" {
  description = "MSK APPCODE"
  default     = "msk"
}

variable "cidrange" {
  description = "Cidr Range"
}

variable "gateway_id" {
  description = "existing gateway id"
}

variable "route-table-name" {
  description = "route table name"
  default     = "rt"
}



variable "security-group-name" {
  description = "Security Group Name"
  default     = "sg"
}


variable "subnet-name" {
  description = "Public subnet name"
  default     = "snt"
}

variable "public-subnet-1-block" {
  description = "Public subnet 2 block"
}

variable "public-subnet-2-block" {
  description = "Public subnet 2 block"
}

variable "private-subnet-1-block" {
  description = "private subnet 1 block"
}

variable "private-subnet-2-block" {
  description = "private subnet 2 block"
}



variable "deployment-id" {
  description = "Deployment id"
}




variable "nat-name" {
  description = "NAT  name"
  default     = "nat"
}


variable "nacl-name" {
  description = "Public NACL Name"
  default     = "ncl"
}




variable "az1" {
  description = "Availability Zone 1"
}

variable "az2" {
  description = "Availability Zone 2"
}






variable "alb-security-group-name" {
  default = "sg"
}

variable "alb-appcode" {
  default = "alb"
}

variable "alb-name" {
  default = "alb"
}

variable "appname" {
  description = "Application"
  default     = "Infra"
}

variable "appowner" {
  description = "Application Owner"
}

variable "environment" {
  description = "Environment"
}

variable "approle" {
  description = "Application Role"
  default     = "Bucket"
}

variable "snt-approle" {
  description = "Application Role"
  default     = "Subnet"
}

variable "sg-approle" {
  description = "Application Role"
  default     = "Security Group"
}

variable "vpc-approle" {
  description = "Application Role"
  default     = "VPC"
}

variable "nat-approle" {
  description = "Application Role"
  default     = "NAT"
}

variable "nacl-approle" {
  description = "Application Role"
  default     = "NACL"
}

variable "rt-approle" {
  description = "Application Role"
  default     = "Route Table"
}

variable "alb-appname" {
  description = "Application"
  default     = "Infra"
}

variable "alb-approle" {
  description = "Application Role"
  default     = "Load Balance"
}

variable "alb-sg-approle" {
  description = "Application Role"
  default     = "Security Group"
}

variable "alb-sr-approle" {
  description = "Application Role"
  default     = "Secrets"
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


variable "tg-appname" {
  description = "Application"
  default     = "Infra"
}

variable "tg-approle" {
  description = "Application Role"
  default     = "Load Balance"
}
