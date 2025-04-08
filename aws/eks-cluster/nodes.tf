module "eks_managed_node_group" {
  source = "./modules/managed-node-group"

  for_each = var.node_groups

  name         = each.value.node_group_name
  cluster_name = aws_eks_cluster.master.name
  subnet_ids   = var.private_subnet_ids

  min_size     = each.value.min_size
  max_size     = each.value.max_size
  desired_size = each.value.desired_size

  instance_types = each.value.instance_types
  capacity_type  = "ON_DEMAND"

  taints = each.value.taints
  labels = each.value.labels
}
