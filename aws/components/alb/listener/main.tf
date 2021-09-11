resource "aws_lb_listener" "listener" {
  load_balancer_arn = var.lb-arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = var.target-group-arn
  }
}

output "arn" {
  value = aws_lb_listener.listener.arn
}