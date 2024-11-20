resource "aws_eks_node_group" "default" {
  for_each = var.node_groups

  cluster_name    = local.cluster_name
  node_group_name = each.value.node_group_name
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.private_subnet_ids
  disk_size       = each.value.disk_size
  instance_types  = each.value.instance_types
  version         = var.cluster_version

  lifecycle {
    ignore_changes = [
      remote_access
    ]
  }

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  dynamic "taint" {
    for_each = each.value.taint != null ? each.value.taint : []
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_policy_attachments,
    aws_eks_cluster.master
  ]
}
