resource "aws_iam_role" "this" {
  for_each = var.access_entries

  name                  = each.value.principal_name
  assume_role_policy    = data.aws_iam_policy_document.this[each.key].json
  permissions_boundary  = var.permissions_boundary
  path                  = var.iam_path
  force_detach_policies = true
}
