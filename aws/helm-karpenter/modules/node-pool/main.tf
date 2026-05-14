resource "kubernetes_manifest" "nodepool" {
  manifest = {
    apiVersion = "karpenter.sh/v1"
    kind       = "NodePool"
    metadata = {
      name = var.name
    }
    spec = {
      template = {
        metadata = length(var.labels) > 0 ? { labels = var.labels } : null
        spec = {
          requirements = var.requirements
          nodeClassRef = {
            group = "karpenter.k8s.aws"
            kind  = "EC2NodeClass"
            name  = var.ec2_node_class_name
          }
          taints      = length(var.taints) > 0 ? var.taints : null
          expireAfter = var.expire_after
        }
      }
      limits = {
        cpu    = var.cpu_limit
        memory = var.memory_limit
      }
      disruption = {
        consolidationPolicy = var.consolidation_policy
        consolidateAfter    = var.consolidate_after
      }
    }
  }

  depends_on = [var.depends_on_resources]
}
