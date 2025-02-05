locals {
  cluster_name = "${var.name}-eks-${var.environment}"
  namespaces   = { for namespace in var.custom_namespaces : namespace => namespace }
}
