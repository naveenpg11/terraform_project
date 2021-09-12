resource "aws_ecs_capacity_provider" "provider" {
  name = var.name
  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.auto_scaling_group_arn

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 90
    }
  }
}


output "name" {
  value = aws_ecs_capacity_provider.provider.name
  depends_on  = [aws_ecs_capacity_provider.provider]
}
