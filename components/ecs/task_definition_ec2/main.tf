resource "aws_ecs_task_definition" "task_definition" {
  family = "api-email-service"
  requires_compatibilities = [
      "EC2"
   ]
  cpu = var.task_cpu
  memory = var.task_memory
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image_id
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
    }
  ])
}

output "id" {
  value  = aws_ecs_task_definition.task_definition.id
}
