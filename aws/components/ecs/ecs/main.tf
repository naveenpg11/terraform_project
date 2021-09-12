
resource "aws_ecs_cluster" "web-cluster" {
  name               = var.name
  capacity_providers = [var.capacity_provider]

  tags  = var.tags
}


output id {
  value       = aws_ecs_cluster.web-cluster.id
}
