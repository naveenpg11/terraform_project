resource "aws_iam_group" "iam_group" {
  name = var.name
}

output "grp_name" {
  value = aws_iam_group.iam_group.name
}