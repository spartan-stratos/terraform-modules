# Example: complete Karpenter deployment using preset-based NodePools.
#
# Two-step deployment (CRD bootstrap):
#   Step 1: terraform apply -target=module.karpenter.helm_release.karpenter
#   Step 2: set enable_karpenter_resources=true, then: terraform apply

module "karpenter" {
  source = "../../"

  environment = var.environment

  cluster_name      = var.cluster_name
  cluster_endpoint  = var.cluster_endpoint
  oidc_provider_arn = var.oidc_provider_arn
  oidc_provider_url = var.oidc_provider_url

  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids

  enable_node_pools = var.enable_karpenter_resources

  node_pools = {
    # On-demand builder pool for reliable CI/CD releases
    builder = {
      preset = "builder"
    }

    # Spot builder pool for cost-effective dev builds and PR checks
    builder-spot = {
      preset = "builder-spot"
    }

    # General application workloads
    apps = {
      preset    = "general-purpose"
      cpu_limit = "64"
    }

    # Custom pool example: labelled nodes for a specific service
    data-processing = {
      preset = "compute-optimized"
      labels = {
        "workload-type" = "data-processing"
      }
      taints = [
        {
          key    = "workload-type"
          value  = "data-processing"
          effect = "NoSchedule"
        }
      ]
    }
  }
}
