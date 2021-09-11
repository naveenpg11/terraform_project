resource "aws_ecs_task_definition" "task_definition" {
  family = "api-service"
  requires_compatibilities = [
      "EC2"
   ]
  cpu = "500"
  memory = "500"
  container_definitions = jsonencode([
    {
      name      = "container-api"
      image     = var.container-image-id
      cpu       = 200
      memory    = 300
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ]
    }
  ])
}

output "task_definition_id" {
  value       = aws_ecs_task_definition.task_definition[0].id
}
