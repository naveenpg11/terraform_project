
resource "aws_lb_target_group" "dev-tg" {
  name     = var.target-group-name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc-id

  health_check {
    protocol            = var.health-check-protocol
    path                = var.health-check-path
    port                = var.health-check-port
    healthy_threshold   = var.healthy-threshold
    unhealthy_threshold = var.unhealthy-threshold
    timeout             = var.health-check-timeout
    interval            = var.health-check-interval
    matcher             = var.health-check-matcher
  }

  tags = var.tags
}


# resource "aws_lb_target_group_attachment" "dev-tg-attachment" {
#   count            = length(var.instance-ids)
#   target_group_arn = aws_lb_target_group.dev-tg.arn
#   # target_id        = var.instance-ids[count.index]
#   port             = var.port
# }


output "tg-arn" {
  value = aws_lb_target_group.dev-tg.arn
}
