resource "aws_iam_role" "this" {
  for_each = toset(var.assume_role)

  name                  = each.value.name
  assume_role_policy    = data.aws_iam_policy_document.this[each.key].json
  force_detach_policies = true
}