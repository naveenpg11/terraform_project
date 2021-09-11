resource "aws_iam_policy" "policy" {
  count		    = var.resource_count
  name        = var.name
  description = var.description
  policy      = var.policy
}
module "policy_role_attachment" {
  source              = "../iam_role_policy_attachment"
  count				        = var.iam_role != "" ? 1 : 0
  policy_arn          = aws_iam_policy.policy[0].arn
  iam_role            = var.iam_role
}
module "group_policy_attachment" {
  source              = "../iam_group_policy_attachment"
  count				        = var.group_name != "" ? 1 : 0
  policy_arn          = aws_iam_policy.policy[0].arn
  group_name          = var.group_name
}

