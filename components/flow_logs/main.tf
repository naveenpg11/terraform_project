resource "aws_flow_log" "example" {
  log_destination      = var.s3-arn
  log_destination_type = "s3"
  traffic_type         = var.traffic-type
  vpc_id               = var.vpc-id

  tags = var.tags
}
