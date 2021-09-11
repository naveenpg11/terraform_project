variable "alb_listener_arn" {
    default = "arn:aws:elasticloadbalancing:us-east-2:974638887567:listener/app/interview-alb-bi-dev-use2-01/fd6af03fcaa97a08/75c30339ed4c9540"
}

variable "vpc_id" {
    default = "vpc-052dd737c46780df6"
}

variable "private_subnet_1_id" {
    default = "subnet-0c803529fd499c2b3"
}
variable "private_subnet_2_id" {
    default = "subnet-02e5661f4e6b85c6d"
}


# variable  {
#     default = "interview-alb-bi-dev-use2-01-576085688.us-east-2.elb.amazonaws.com"
# }