# Karpenter Module - Main Orchestration

# ============================================================================
# Karpenter CRD Installation
# ============================================================================

resource "helm_release" "karpenter-crd" {
  chart           = "karpenter-crd"
  name            = "karpenter-crd"
  namespace       = "kube-system"
  version         = var.karpenter_version
  repository      = "oci://public.ecr.aws/karpenter"
  upgrade_install = true
  force_update    = true
}


# ============================================================================
# Karpenter Helm Chart Installation
# ============================================================================

resource "helm_release" "karpenter" {
  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = var.karpenter_version
  namespace  = var.karpenter_namespace

  create_namespace = true
  upgrade_install  = true
  force_update     = true

  set = flatten([
    [
      {
        name  = "settings.clusterName"
        value = var.cluster_name
      },
      {
        name  = "settings.clusterEndpoint"
        value = var.cluster_endpoint
      },
      {
        name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
        value = aws_iam_role.karpenter_controller.arn
      },
      {
        name  = "replicas"
        value = var.karpenter_replicas
      },
    ],
    [for k, v in var.node_selector : {
      name  = "nodeSelector.${k}"
      value = v
    }],
    flatten([for i, t in var.tolerations : concat(
      [
        { name = "tolerations[${i}].key", value = t.key },
        { name = "tolerations[${i}].operator", value = t.operator },
        { name = "tolerations[${i}].effect", value = t.effect },
      ],
      t.value == null ? [] : [
        { name = "tolerations[${i}].value", value = t.value },
      ],
    )]),
  ])

  depends_on = [
    aws_iam_role.karpenter_controller,
    aws_iam_role_policy_attachment.karpenter_controller,
    helm_release.karpenter-crd
  ]
}

# ============================================================================
# EC2NodeClass Resources (one per NodePool)
# ============================================================================

module "node_classes" {
  for_each = var.enable_node_pools ? local.transformed_node_pools : {}

  source = "./modules/node-class"

  name               = each.key
  ami_family         = var.ami_family
  ami_alias          = var.ami_alias
  node_iam_role_name = aws_iam_role.karpenter_node.name
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids

  volume_size       = each.value.volume_size
  volume_type       = each.value.volume_type
  volume_iops       = each.value.volume_iops
  volume_throughput = each.value.volume_throughput
  imds_hop_limit    = var.imds_hop_limit

  depends_on_resources = [
    helm_release.karpenter,
    helm_release.karpenter-crd,
    aws_iam_role.karpenter_node,
    aws_iam_instance_profile.karpenter_node
  ]
}

# ============================================================================
# NodePool Resources (one per configuration)
# ============================================================================

module "node_pools" {
  for_each = var.enable_node_pools ? local.transformed_node_pools : {}

  source = "./modules/node-pool"

  name                 = each.key
  requirements         = local.node_pool_requirements[each.key]
  ec2_node_class_name  = each.key
  cpu_limit            = each.value.cpu_limit
  memory_limit         = each.value.memory_limit
  consolidation_policy = each.value.consolidation_policy
  consolidate_after    = each.value.consolidate_after
  expire_after         = each.value.expire_after

  labels = try(each.value.labels, {})
  taints = try(each.value.taints, [])

  depends_on_resources = [
    helm_release.karpenter,
    helm_release.karpenter-crd,
    module.node_classes
  ]
}
