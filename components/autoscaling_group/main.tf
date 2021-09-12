

resource "aws_autoscaling_group" "asg" {
  name                      = var.name
  launch_configuration      = var.launch_template_ecs
  min_size                  = var.min_count
  max_size                  = var.max_count
  desired_capacity          = var.desired_count
  health_check_type         = "ELB"
  health_check_grace_period = 300
  vpc_zone_identifier       = [var.private_subnet_1_id, var.private_subnet_2_id]

  # tags = var.tags
}

output "asg_arn" {
    value = aws_autoscaling_group.asg.arn
}