# AWS Karpenter Module

Terraform module for deploying [Karpenter](https://karpenter.sh/) on Amazon EKS with preset-based NodePool configuration.

## Features

- **Preset-based configuration**: 5 built-in workload presets (builder, builder-spot, general-purpose, compute-optimized, memory-optimized)
- **Full customization support**: Override preset values or provide completely custom configurations
- **Multi-environment ready**: Minimal environment-specific configuration
- **IRSA-enabled**: IAM Roles for Service Accounts for secure controller authentication
- **Production-ready defaults**: Sensible defaults for disruption handling, consolidation, and node expiration

## Quick Start

### Minimal Example (Preset-based)

```hcl
module "karpenter" {
  source  = "c0x12c/helm-karpenter/aws"
  version = "~> 0.1"

  environment = "dev"

  cluster_name      = module.backbone.eks_cluster_name
  cluster_endpoint  = module.backbone.eks_cluster_endpoint
  oidc_provider_arn = module.backbone.eks_oidc_provider.arn
  oidc_provider_url = module.backbone.eks_oidc_provider.url

  subnet_ids         = module.backbone.private_subnet_ids
  security_group_ids = [
    module.backbone.security_group_allow_all_within_vpc_id,
    module.backbone.eks_cluster_security_group_id
  ]

  enable_node_pools = var.enable_karpenter_resources

  node_pools = {
    builder = { preset = "builder" }
  }
}
```

## Available Presets

| Preset | Use Case | Instance Families | Default Limits | Capacity Type |
|--------|----------|-------------------|----------------|---------------|
| **builder** | CI/CD workloads (GitHub Actions, on-demand reliability) | t3, m5n, m5, m5a, m6i, m6a, m7i, c5n, c5, c6i, c6a, c7i | 96 CPU / 384Gi | on-demand |
| **builder-spot** | CI/CD workloads (dev / non-blocking, cost-optimised) | t3, m5a, m5, m6i, m6a, m7i, c5, c6i, c6a, c7i | 96 CPU / 384Gi | spot + on-demand |
| **general-purpose** | Balanced application workloads | t3, m5, m5a, m6i, m6a, m7i | 32 CPU / 128Gi | spot + on-demand |
| **compute-optimized** | CPU-intensive workloads | c5, c5a, c5n, c6i, c6a, c7i | 64 CPU / 128Gi | spot + on-demand |
| **memory-optimized** | Memory-intensive workloads | r5, r5a, r6i, r6a, r7i | 32 CPU / 256Gi | spot + on-demand |

### Preset Details

**Builder Preset**:
- Enhanced networking prioritized (m5n/c5n first) for faster image pulls
- High IOPS (10,000) and throughput (500 MB/s) for Docker layer caching
- 1-hour consolidation delay to reuse cached images
- 30-day node expiration for security updates
- On-demand only for reliable production builds and releases

**Builder-Spot Preset**:
- Same instance families as `builder` (minus enhanced-networking variants) but with spot first, on-demand fallback
- ~70% cost savings vs on-demand; 30-minute consolidation to reduce spot waste
- Suitable for: dev environment builds, PR checks, non-blocking tests
- Not suitable for: production deployments, time-sensitive releases

**General Purpose Preset**:
- Balanced CPU/memory ratio
- Spot instances enabled for cost savings
- 5-minute consolidation for cost efficiency
- 7-day node expiration

**Compute Optimized Preset**:
- High CPU-to-memory ratio
- Focus on c-family instances
- Spot instances enabled
- Suitable for batch processing, scientific computing

**Memory Optimized Preset**:
- High memory-to-CPU ratio
- r-family instances (up to 4xlarge)
- Suitable for databases, caching, analytics

## Usage Examples

### Override Preset Values

```hcl
node_pools = {
  builder = {
    preset         = "builder"
    cpu_limit      = "128"                       # Override: increase from default 96
    capacity_types = ["spot", "on-demand"]       # Override: enable spot for savings
  }
}
```

### Multiple NodePools (Production)

```hcl
node_pools = {
  apps = {
    preset     = "general-purpose"
    cpu_limit  = "256"
  }
  compute = {
    preset = "compute-optimized"
  }
  memory = {
    preset       = "memory-optimized"
    memory_limit = "512Gi"  # Higher limit for production
  }
}
```

### Fully Custom Configuration

```hcl
node_pools = {
  custom = {
    instance_families = ["m5", "m6i"]
    instance_sizes    = ["xlarge", "2xlarge"]
    architectures     = ["amd64"]
    capacity_types    = ["spot"]

    cpu_limit    = "64"
    memory_limit = "256Gi"

    consolidation_policy = "WhenEmptyOrUnderutilized"
    consolidate_after    = "10m"
    expire_after         = "168h"

    volume_size       = "200Gi"
    volume_type       = "gp3"
    volume_iops       = 16000
    volume_throughput = 1000

    # Optional: Add labels and taints
    labels = {
      workload-type = "custom"
    }
    taints = [
      {
        key    = "workload"
        value  = "custom"
        effect = "NoSchedule"
      }
    ]
  }
}
```

### Staged Deployment (Dev/Prod Pattern)

**Dev Environment** (`envs/dev/karpenter.tf`):
```hcl
module "karpenter" {
  source  = "c0x12c/helm-karpenter/aws"
  version = "~> 0.1"

  environment = local.environment

  # ... cluster and network config

  node_pools = {
    builder = { preset = "builder-spot" }
  }
}
```

**Production Environment** (`envs/prod/karpenter.tf`):
```hcl
module "karpenter" {
  source  = "c0x12c/helm-karpenter/aws"
  version = "~> 0.1"

  environment = local.environment

  # ... cluster and network config

  node_pools = {
    apps = {
      preset     = "general-purpose"
      cpu_limit  = "256"
    }
    builder = {
      preset         = "builder"
      cpu_limit      = "128"
      capacity_types = ["spot", "on-demand"]
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Environment name (dev, staging, prod) | `string` | - | yes |
| cluster_name | EKS cluster name | `string` | - | yes |
| cluster_endpoint | EKS cluster endpoint URL | `string` | - | yes |
| oidc_provider_arn | EKS OIDC provider ARN for IRSA | `string` | - | yes |
| oidc_provider_url | EKS OIDC provider URL (without https://) | `string` | - | yes |
| subnet_ids | List of subnet IDs for Karpenter nodes | `list(string)` | - | yes |
| security_group_ids | List of security group IDs for Karpenter nodes | `list(string)` | - | yes |
| enable_node_pools | Enable NodePool/EC2NodeClass creation. Set false on first apply (CRD bootstrap). | `bool` | `true` | no |
| karpenter_version | Karpenter Helm chart version | `string` | `"1.8.6"` | no |
| karpenter_namespace | Kubernetes namespace for Karpenter | `string` | `"karpenter"` | no |
| karpenter_replicas | Number of Karpenter controller replicas | `number` | `1` | no |
| node_pools | Map of NodePool configurations (preset or custom) | `map(any)` | `{}` | no |
| additional_node_policies | Additional IAM policy ARNs for node role | `list(string)` | `[]` | no |
| ami_family | AMI family for Karpenter nodes | `string` | `"AL2023"` | no |
| ami_alias | AMI alias selector | `string` | `"al2023@latest"` | no |
| imds_hop_limit | IMDS hop limit for instance metadata access (must be >= 2 for IRSA in pods) | `number` | `2` | no |

## Outputs

| Name | Description |
|------|-------------|
| controller_role_arn | ARN of the Karpenter controller IAM role |
| controller_role_name | Name of the Karpenter controller IAM role |
| node_role_arn | ARN of the Karpenter node IAM role |
| node_role_name | Name of the Karpenter node IAM role |
| node_instance_profile_arn | ARN of the Karpenter node instance profile |
| node_pools | Map of deployed NodePool configurations (after preset merging) |
| available_presets | List of available NodePool presets |
| helm_release_version | Deployed Karpenter Helm chart version |
| helm_release_namespace | Kubernetes namespace where Karpenter is deployed |

## Architecture

### Module Structure

```
centralized/registry/aws/terraform-aws-helm-karpenter/
├── main.tf              # Helm chart + nested module orchestration
├── iam.tf               # IAM roles (controller + nodes)
├── variables.tf         # Module inputs
├── locals.tf            # Preset merging logic
├── presets.tf           # 5 workload preset definitions
├── outputs.tf           # Module outputs
├── versions.tf          # Terraform/provider constraints
├── data.tf              # Data sources (region, caller identity)
├── README.md            # Documentation
└── modules/
    ├── node-pool/       # NodePool kubernetes_manifest
    │   ├── main.tf
    │   ├── variables.tf
    │   └── versions.tf
    └── node-class/      # EC2NodeClass kubernetes_manifest
        ├── main.tf
        ├── variables.tf
        └── versions.tf
```

### IAM Roles

**Controller Role** (IRSA):
- Trust policy: EKS OIDC provider
- Permissions: EC2 instance management, IAM PassRole, pricing API access
- Service Account: `karpenter:karpenter`

**Node Role**:
- Trust policy: EC2 service
- Managed policies: EKSWorkerNodePolicy, EKS_CNI_Policy, EC2ContainerRegistryReadOnly, SSMManagedInstanceCore
- The EC2NodeClass `spec.role` field references this role name; Karpenter auto-manages the instance profile

## Security Best Practices

1. **Use Spot Instances Carefully**: For production workloads, use mixed capacity types or on-demand only
2. **Limit Resource Consumption**: Set appropriate CPU/memory limits per NodePool
3. **Node Expiration**: Regularly rotate nodes for security updates (default: 7-30 days)
4. **IAM Least Privilege**: Only attach additional policies when necessary
5. **Network Isolation**: Use appropriate security groups and subnet selection

## Deployment

### Initial Deployment

```bash
# Step 1: Deploy Karpenter Helm chart first (installs CRDs)
terraform apply -target=module.karpenter.helm_release.karpenter

# Step 2: Enable NodePools after CRDs are installed
# Set enable_karpenter_resources = true in variables.auto.tfvars
terraform apply
```

### Verification

```bash
# Check Karpenter controller
kubectl get pods -n karpenter

# Verify NodePool and EC2NodeClass
kubectl get nodepool
kubectl get ec2nodeclass

# Test node provisioning
kubectl run test-pod --image=nginx --requests=cpu=4,memory=8Gi
kubectl get nodes  # Should see new Karpenter-provisioned node
kubectl delete pod test-pod
```

## Migration from Inline Configuration

Before (300+ lines per environment):
```hcl
locals { ... }
resource "kubernetes_manifest" "karpenter_nodepool_builder" { ... }
resource "kubernetes_manifest" "karpenter_nodeclass_builder" { ... }
resource "aws_iam_role" "karpenter_node_builder" { ... }
# ... 300+ more lines
```

After (~20 lines):
```hcl
module "karpenter" {
  source  = "c0x12c/helm-karpenter/aws"
  version = "~> 0.1"

  environment = local.environment

  cluster_name      = module.backbone.eks_cluster_name
  cluster_endpoint  = module.backbone.eks_cluster_endpoint
  oidc_provider_arn = module.backbone.eks_oidc_provider.arn
  oidc_provider_url = module.backbone.eks_oidc_provider.url

  subnet_ids         = module.backbone.private_subnet_ids
  security_group_ids = [
    module.backbone.security_group_allow_all_within_vpc_id,
    module.backbone.eks_cluster_security_group_id
  ]

  enable_node_pools = var.enable_karpenter_resources

  node_pools = {
    builder = { preset = "builder" }
  }
}
```

## Troubleshooting

### Nodes Not Joining Cluster

- Verify IAM role has correct trust policy (EC2 service)
- Check EKS access entry is created
- Ensure security groups allow cluster communication
- Verify subnet tags for Karpenter discovery

### Controller Not Provisioning Nodes

- Check controller logs: `kubectl logs -n karpenter -l app.kubernetes.io/name=karpenter`
- Verify IRSA is configured correctly
- Ensure NodePool requirements match pod requirements
- Check capacity limits aren't exceeded

### High Costs

- Enable spot instances in capacity_types
- Reduce consolidate_after timeout
- Lower cpu_limit and memory_limit
- Review instance family selection

## Version Compatibility

- Karpenter: 1.8.6
- Terraform: >= 1.10
- AWS Provider: >= 5.75.0
- Kubernetes Provider: >= 2.33.0
- Helm Provider: ~> 3.0
- EKS: 1.30+ (for access entry support)

## References

- [Karpenter Documentation](https://karpenter.sh/)
- [Karpenter Best Practices](https://aws.github.io/aws-eks-best-practices/karpenter/)
- [EKS Access Entries](https://docs.aws.amazon.com/eks/latest/userguide/access-entries.html)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.75.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.33.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.44.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_node_classes"></a> [node\_classes](#module\_node\_classes) | ./modules/node-class | n/a |
| <a name="module_node_pools"></a> [node\_pools](#module\_node\_pools) | ./modules/node-pool | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_access_entry.karpenter_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_entry) | resource |
| [aws_iam_instance_profile.karpenter_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.karpenter_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.karpenter_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.karpenter_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.karpenter_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.karpenter_node_AmazonEC2ContainerRegistryReadOnly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.karpenter_node_AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.karpenter_node_AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.karpenter_node_AmazonSSMManagedInstanceCore](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.karpenter_node_additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.karpenter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.karpenter-crd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_node_policies"></a> [additional\_node\_policies](#input\_additional\_node\_policies) | Additional IAM policy ARNs to attach to Karpenter node role | `list(string)` | `[]` | no |
| <a name="input_ami_alias"></a> [ami\_alias](#input\_ami\_alias) | AMI alias selector (e.g., al2023@latest) | `string` | `"al2023@latest"` | no |
| <a name="input_ami_family"></a> [ami\_family](#input\_ami\_family) | AMI family for Karpenter nodes | `string` | `"AL2023"` | no |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | EKS cluster endpoint URL | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS cluster name | `string` | n/a | yes |
| <a name="input_enable_node_pools"></a> [enable\_node\_pools](#input\_enable\_node\_pools) | Enable NodePool and EC2NodeClass resource creation. Set to false on first apply to let Karpenter CRDs install before NodePool manifests are created. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, prod) | `string` | n/a | yes |
| <a name="input_imds_hop_limit"></a> [imds\_hop\_limit](#input\_imds\_hop\_limit) | IMDS hop limit - must be >= 2 for containerized workloads with IRSA | `number` | `2` | no |
| <a name="input_karpenter_namespace"></a> [karpenter\_namespace](#input\_karpenter\_namespace) | Kubernetes namespace for Karpenter | `string` | `"karpenter"` | no |
| <a name="input_karpenter_replicas"></a> [karpenter\_replicas](#input\_karpenter\_replicas) | Number of Karpenter controller replicas | `number` | `1` | no |
| <a name="input_karpenter_version"></a> [karpenter\_version](#input\_karpenter\_version) | Karpenter Helm chart version | `string` | `"1.12.0"` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | Map of NodePool configurations. Each pool can use a preset or custom configuration.<br/><br/>Preset-based example:<br/>  node\_pools = {<br/>    builder = { preset = "builder" }<br/>    apps    = { preset = "general-purpose", cpu\_limit = "128" }<br/>  }<br/><br/>Custom configuration example:<br/>  node\_pools = {<br/>    custom = {<br/>      instance\_families = ["m5", "m6i"]<br/>      instance\_sizes    = ["xlarge", "2xlarge"]<br/>      architectures     = ["amd64"]<br/>      capacity\_types    = ["spot"]<br/>      cpu\_limit         = "32"<br/>      memory\_limit      = "128Gi"<br/>      # ... other fields<br/>    }<br/>  }<br/><br/>Available presets: builder, general-purpose, compute-optimized, memory-optimized | `map(any)` | `{}` | no |
| <a name="input_node_selector"></a> [node\_selector](#input\_node\_selector) | Node selector for Karpenter | `map(string)` | `{}` | no |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | EKS OIDC provider ARN for IRSA | `string` | n/a | yes |
| <a name="input_oidc_provider_url"></a> [oidc\_provider\_url](#input\_oidc\_provider\_url) | EKS OIDC provider URL (without https://) | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs for Karpenter-provisioned nodes | `list(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for Karpenter-provisioned nodes | `list(string)` | n/a | yes |
| <a name="input_tolerations"></a> [tolerations](#input\_tolerations) | Tolerations for Karpenter | <pre>list(object({<br/>    key      = string<br/>    operator = string<br/>    value    = optional(string)<br/>    effect   = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_available_presets"></a> [available\_presets](#output\_available\_presets) | List of available NodePool presets |
| <a name="output_controller_role_arn"></a> [controller\_role\_arn](#output\_controller\_role\_arn) | ARN of the Karpenter controller IAM role |
| <a name="output_controller_role_name"></a> [controller\_role\_name](#output\_controller\_role\_name) | Name of the Karpenter controller IAM role |
| <a name="output_helm_release_namespace"></a> [helm\_release\_namespace](#output\_helm\_release\_namespace) | Kubernetes namespace where Karpenter is deployed |
| <a name="output_helm_release_version"></a> [helm\_release\_version](#output\_helm\_release\_version) | Deployed Karpenter Helm chart version |
| <a name="output_node_instance_profile_arn"></a> [node\_instance\_profile\_arn](#output\_node\_instance\_profile\_arn) | ARN of the Karpenter node instance profile |
| <a name="output_node_pools"></a> [node\_pools](#output\_node\_pools) | Map of deployed NodePool configurations (after preset merging) |
| <a name="output_node_role_arn"></a> [node\_role\_arn](#output\_node\_role\_arn) | ARN of the Karpenter node IAM role |
| <a name="output_node_role_name"></a> [node\_role\_name](#output\_node\_role\_name) | Name of the Karpenter node IAM role |
<!-- END_TF_DOCS -->