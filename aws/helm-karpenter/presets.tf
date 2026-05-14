# Karpenter NodePool Presets
# Define common workload patterns for easy consumption

locals {
  nodepool_presets = {
    # Builder preset: Optimized for CI/CD workloads (GitHub Actions runners)
    # Prioritizes enhanced networking (m5n/c5n) for faster image pulls
    # Uses on-demand capacity for reliability in critical build pipelines
    builder = {
      instance_families = ["t3", "m5n", "m5", "m5a", "m6i", "m6a", "m7i", "c5n", "c5", "c6i", "c6a", "c7i"]
      instance_sizes    = ["small", "xlarge", "2xlarge", "4xlarge"]
      architectures     = ["amd64"]
      capacity_types    = ["on-demand"]

      cpu_limit    = "96"
      memory_limit = "384Gi"

      consolidation_policy = "WhenEmptyOrUnderutilized"
      consolidate_after    = "1h"   # Keep nodes alive to reuse cached images
      expire_after         = "720h" # 30 days

      volume_size       = "100Gi"
      volume_type       = "gp3"
      volume_iops       = 10000 # Increased for faster image pulls
      volume_throughput = 500   # Increased from default 125 MB/s
    }

    # Builder-Spot preset: Cost-optimized variant for non-critical CI/CD workloads
    # Provides ~70% cost savings with spot instances, fallback to on-demand
    # Suitable for: dev environment builds, PR checks, non-blocking tests
    # Not suitable for: production deployments, time-sensitive releases
    builder-spot = {
      # t3.small is required for the runner-scale-set listener pods (hard nodeSelector).
      # Other families/xlarge are used for the actual runner workloads.
      instance_families = ["t3", "m5a", "m5", "m6i", "m6a", "m7i", "c5", "c6i", "c6a", "c7i"]
      instance_sizes    = ["small", "xlarge"]
      architectures     = ["amd64"]
      capacity_types    = ["spot", "on-demand"] # Spot first, on-demand fallback

      cpu_limit    = "96"
      memory_limit = "384Gi"

      consolidation_policy = "WhenEmptyOrUnderutilized"
      consolidate_after    = "30m" # Shorter than on-demand to reduce waste
      expire_after         = "720h"

      volume_size       = "100Gi"
      volume_type       = "gp3"
      volume_iops       = 10000
      volume_throughput = 500
    }

    # General-purpose preset: Balanced compute and memory for application workloads
    general-purpose = {
      instance_families = ["t3", "m5", "m5a", "m6i", "m6a", "m7i"]
      instance_sizes    = ["medium", "large", "xlarge", "2xlarge"]
      architectures     = ["amd64"]
      capacity_types    = ["spot", "on-demand"]

      cpu_limit    = "32"
      memory_limit = "128Gi"

      consolidation_policy = "WhenEmptyOrUnderutilized"
      consolidate_after    = "5m"
      expire_after         = "168h" # 7 days

      volume_size       = "50Gi"
      volume_type       = "gp3"
      volume_iops       = 3000
      volume_throughput = 125
    }

    # Compute-optimized preset: High CPU ratio for compute-intensive workloads
    compute-optimized = {
      instance_families = ["c5", "c5a", "c5n", "c6i", "c6a", "c7i"]
      instance_sizes    = ["large", "xlarge", "2xlarge", "4xlarge"]
      architectures     = ["amd64"]
      capacity_types    = ["spot", "on-demand"]

      cpu_limit    = "64"
      memory_limit = "128Gi"

      consolidation_policy = "WhenEmptyOrUnderutilized"
      consolidate_after    = "5m"
      expire_after         = "168h" # 7 days

      volume_size       = "50Gi"
      volume_type       = "gp3"
      volume_iops       = 3000
      volume_throughput = 125
    }

    # Memory-optimized preset: High memory ratio for memory-intensive workloads
    memory-optimized = {
      instance_families = ["r5", "r5a", "r6i", "r6a", "r7i"]
      instance_sizes    = ["large", "xlarge", "2xlarge", "4xlarge"]
      architectures     = ["amd64"]
      capacity_types    = ["spot", "on-demand"]

      cpu_limit    = "32"
      memory_limit = "256Gi"

      consolidation_policy = "WhenEmptyOrUnderutilized"
      consolidate_after    = "5m"
      expire_after         = "168h" # 7 days

      volume_size       = "50Gi"
      volume_type       = "gp3"
      volume_iops       = 3000
      volume_throughput = 125
    }
  }
}
