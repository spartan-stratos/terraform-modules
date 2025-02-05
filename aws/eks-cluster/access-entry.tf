resource "aws_eks_access_entry" "this" {
  for_each = { for k, v in var.access_entries : k => v if var.enabled_api || var.enabled_api_and_config_map }

  cluster_name      = local.cluster_name
  kubernetes_groups = try(each.value.kubernetes_groups, null)
  principal_arn     = each.value.principal_arn
  type              = try(each.value.type, "STANDARD")
}

resource "aws_eks_access_policy_association" "this" {
  for_each = { for k, v in var.access_entries : k => v if var.enabled_api || var.enabled_api_and_config_map && v.policy_arn != null }

  access_scope {
    namespaces = try(each.value.namespaces, [])
    type       = try(each.value.access_type, "CLUSTER")
  }

  cluster_name = local.cluster_name

  policy_arn    = each.value.policy_arn
  principal_arn = each.value.principal_arn

  depends_on = [
    aws_eks_access_entry.this,
  ]
}
