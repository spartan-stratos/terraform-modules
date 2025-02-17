resource "aws_iam_role" "this" {
  for_each = { for k, v in var.access_entries : k => v if v.trusted_role_arn != null }

  name                  = each.key
  assume_role_policy    = data.aws_iam_policy_document.this[each.key].json
  permissions_boundary  = var.permissions_boundary
  path                  = var.iam_path
  force_detach_policies = true
}
