resource "kubernetes_manifest" "ec2nodeclass" {
  manifest = {
    apiVersion = "karpenter.k8s.aws/v1"
    kind       = "EC2NodeClass"
    metadata = {
      name = var.name
    }
    spec = {
      amiFamily = var.ami_family
      amiSelectorTerms = [
        {
          alias = var.ami_alias
        }
      ]
      role = var.node_iam_role_name

      # Convert subnet IDs to selector terms
      subnetSelectorTerms = [
        for subnet_id in var.subnet_ids : {
          id = subnet_id
        }
      ]

      # Convert security group IDs to selector terms
      securityGroupSelectorTerms = [
        for sg_id in var.security_group_ids : {
          id = sg_id
        }
      ]

      blockDeviceMappings = [
        {
          deviceName = "/dev/xvda"
          ebs = {
            volumeSize          = var.volume_size
            volumeType          = var.volume_type
            iops                = var.volume_iops
            throughput          = var.volume_throughput
            encrypted           = true
            deleteOnTermination = true
          }
        }
      ]

      # IMDS configuration - CRITICAL for containerized workloads with IRSA
      # httpPutResponseHopLimit must be >= 2 for pods to access IMDS
      # See: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-IMDS-new-instances.html
      metadataOptions = {
        httpEndpoint            = "enabled"
        httpProtocolIPv6        = "disabled"
        httpPutResponseHopLimit = var.imds_hop_limit # Must be >= 2 for containerized workloads with IRSA
        httpTokens              = "required"         # IMDSv2 required for security
      }

      # Note: PID limits configuration removed temporarily to debug node join issues
      # Will add back using proper AL2023 configuration method once nodes are joining
    }
  }

  field_manager {
    force_conflicts = true
  }

  depends_on = [var.depends_on_resources]
}
