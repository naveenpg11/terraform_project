resource "aws_iam_role_policy_attachment" "policy_attahment" {
  count      = var.resource_count
  policy_arn = var.policy_arn
  role       = var.iam_role
}