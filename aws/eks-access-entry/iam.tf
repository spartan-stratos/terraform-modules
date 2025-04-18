resource "aws_iam_role" "this" {
  for_each = { for i, entry in var.assume_role : entry.name => entry }

  name                  = each.value.name
  assume_role_policy    = data.aws_iam_policy_document.this[each.key].json
  force_detach_policies = true
}