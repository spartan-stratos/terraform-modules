# Local computed values and preset merging logic

locals {
  # IAM role names with environment suffix
  controller_role_name = "karpenter-controller-${var.environment}"
  node_role_name       = "karpenter-node-${var.environment}"

  # Base node pool structure with empty/null defaults for type consistency
  base_node_pool_structure = {
    instance_families    = []
    instance_sizes       = []
    architectures        = []
    capacity_types       = []
    cpu_limit            = null
    memory_limit         = null
    consolidation_policy = null
    consolidate_after    = null
    expire_after         = null
    volume_size          = null
    volume_type          = null
    volume_iops          = null
    volume_throughput    = null
  }

  # Transform node_pools configuration by merging preset defaults with user overrides
  # Pattern: If "preset" key exists, start with preset defaults, then merge user overrides
  #          Otherwise, use custom configuration as-is
  transformed_node_pools = {
    for name, config in var.node_pools : name => merge(
      # Start with base structure to ensure type consistency
      local.base_node_pool_structure,
      # Merge preset if specified (or base structure if not)
      try(config.preset, null) != null ? local.nodepool_presets[config.preset] : local.base_node_pool_structure,
      # Merge user overrides (excluding preset key and null values).
      # Null values come from optional() fields the caller didn't set —
      # they must NOT clobber the preset's defaults.
      { for k, v in config : k => v if k != "preset" && v != null }
    )
  }

  # Construct Karpenter requirements list from transformed config
  # This is used by the NodePool kubernetes_manifest
  node_pool_requirements = {
    for name, config in local.transformed_node_pools : name => concat(
      # Architecture requirement
      [{
        key      = "kubernetes.io/arch"
        operator = "In"
        values   = config.architectures
      }],

      # OS requirement (always linux)
      [{
        key      = "kubernetes.io/os"
        operator = "In"
        values   = ["linux"]
      }],

      # Capacity type requirement (spot/on-demand)
      [{
        key      = "karpenter.sh/capacity-type"
        operator = "In"
        values   = config.capacity_types
      }],

      # Instance family requirement
      [{
        key      = "karpenter.k8s.aws/instance-family"
        operator = "In"
        values   = config.instance_families
      }],

      # Instance size requirement
      [{
        key      = "karpenter.k8s.aws/instance-size"
        operator = "In"
        values   = config.instance_sizes
      }]
    )
  }
}
