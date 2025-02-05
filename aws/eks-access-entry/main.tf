resource "aws_eks_access_entry" "this" {
  for_each = { for k, v in var.access_entries : k => v }

  cluster_name      = local.cluster_name
  kubernetes_groups = try(each.value.kubernetes_groups, null)
  principal_arn     = "arn:aws:iam::${var.aws_account_id}:role/${each.value.principal_name}"
  type              = try(each.value.type, "STANDARD")
}

resource "aws_eks_access_policy_association" "this" {
  for_each = { for k, v in var.access_entries : k => v if v.policy_arn != null }

  access_scope {
    namespaces = try(each.value.namespaces, [])
    type       = try(each.value.access_type, "cluster")
  }

  cluster_name = local.cluster_name

  policy_arn    = each.value.policy_arn
  principal_arn = "arn:aws:iam::${var.aws_account_id}:role/${each.value.principal_name}"

  depends_on = [
    aws_eks_access_entry.this,
  ]
}
