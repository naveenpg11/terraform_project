resource "aws_iam_role" "default" {
  count              = var.resource_count
  name               = var.name
  assume_role_policy = var.policy
}

output "role_arn" {
  value = aws_iam_role.default[0].arn
}

output "role_name" {
  value = aws_iam_role.default[0].name
}