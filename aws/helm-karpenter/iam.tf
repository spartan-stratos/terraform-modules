# IAM Resources for Karpenter Controller and Nodes

# ============================================================================
# Karpenter Controller IAM Role (IRSA)
# ============================================================================

resource "aws_iam_role" "karpenter_controller" {
  name = local.controller_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
      Condition = {
        StringEquals = {
          "${var.oidc_provider_url}:sub" = "system:serviceaccount:${var.karpenter_namespace}:karpenter"
          "${var.oidc_provider_url}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })

  tags = {
    Name        = local.controller_role_name
    Environment = var.environment
  }
}

resource "aws_iam_policy" "karpenter_controller" {
  name = local.controller_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Read-only describe actions - require Resource = "*" but restricted by region
      {
        Sid    = "DescribeActions"
        Effect = "Allow"
        Action = [
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeImages",
          "ec2:DescribeInstanceTypeOfferings",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplates",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSpotPriceHistory",
          "ec2:DescribeSubnets"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = data.aws_region.current.id
          }
        }
      },
      # Pricing API - global, no region condition
      {
        Sid    = "PricingActions"
        Effect = "Allow"
        Action = [
          "pricing:GetProducts"
        ]
        Resource = "*"
      },
      # Instance and fleet management actions - restricted by region
      {
        Sid    = "InstanceManagement"
        Effect = "Allow"
        Action = [
          "ec2:CreateFleet",
          "ec2:RunInstances",
          "ec2:TerminateInstances",
          "ec2:DescribeInstances"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = data.aws_region.current.id
          }
        }
      },
      # Launch template management - restricted by region
      {
        Sid    = "LaunchTemplateManagement"
        Effect = "Allow"
        Action = [
          "ec2:CreateLaunchTemplate",
          "ec2:DeleteLaunchTemplate",
          "ec2:CreateTags"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = data.aws_region.current.id
          }
        }
      },
      # SSM parameter access for EKS-optimized AMI IDs
      {
        Sid      = "SSMParameterAccess"
        Effect   = "Allow"
        Action   = ["ssm:GetParameter"]
        Resource = "arn:aws:ssm:${data.aws_region.current.id}::parameter/aws/service/*"
      },
      # IAM PassRole - scoped to node role
      {
        Sid      = "PassNodeRole"
        Effect   = "Allow"
        Action   = ["iam:PassRole"]
        Resource = aws_iam_role.karpenter_node.arn
      },
      # Instance profile management - restricted by naming convention
      {
        Sid    = "InstanceProfileManagement"
        Effect = "Allow"
        Action = [
          "iam:CreateInstanceProfile",
          "iam:DeleteInstanceProfile",
          "iam:GetInstanceProfile",
          "iam:AddRoleToInstanceProfile",
          "iam:RemoveRoleFromInstanceProfile",
          "iam:TagInstanceProfile"
        ]
        Resource = [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:instance-profile/${var.cluster_name}_*",
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:instance-profile/KarpenterNodeInstanceProfile-*",
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:instance-profile/karpenter/*",
        ]
      },
      {
        Sid    = "ListInstanceProfiles"
        Effect = "Allow"
        Action = [
          "iam:ListInstanceProfiles"
        ]
        Resource = "*"
      },
      # EKS cluster describe - restricted to region
      {
        Sid      = "EKSDescribeCluster"
        Effect   = "Allow"
        Action   = ["eks:DescribeCluster"]
        Resource = "arn:aws:eks:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:cluster/${var.cluster_name}"
      }
    ]
  })

  tags = {
    Name        = local.controller_role_name
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "karpenter_controller" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = aws_iam_policy.karpenter_controller.arn
}

# ============================================================================
# Karpenter Node IAM Role
# ============================================================================

resource "aws_iam_role" "karpenter_node" {
  name = local.node_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = local.node_role_name
    Environment = var.environment
  }
}

# Attach required AWS managed policies for EKS worker nodes
resource "aws_iam_role_policy_attachment" "karpenter_node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.karpenter_node.name
}

resource "aws_iam_role_policy_attachment" "karpenter_node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.karpenter_node.name
}

resource "aws_iam_role_policy_attachment" "karpenter_node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.karpenter_node.name
}

resource "aws_iam_role_policy_attachment" "karpenter_node_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.karpenter_node.name
}

# Attach additional custom policies if provided
resource "aws_iam_role_policy_attachment" "karpenter_node_additional" {
  for_each = toset(var.additional_node_policies)

  policy_arn = each.value
  role       = aws_iam_role.karpenter_node.name
}

# The instance profile below is kept for reference and compatibility; Karpenter's
# controller auto-creates/manages instance profiles via iam:CreateInstanceProfile
# using the role name from EC2NodeClass spec.role. It can be removed in a future cleanup.
resource "aws_iam_instance_profile" "karpenter_node" {
  name = local.node_role_name
  role = aws_iam_role.karpenter_node.name

  tags = {
    Name        = local.node_role_name
    Environment = var.environment
  }
}

# EKS access entry for Karpenter nodes (EKS 1.30+)
resource "aws_eks_access_entry" "karpenter_node" {
  cluster_name  = var.cluster_name
  principal_arn = aws_iam_role.karpenter_node.arn
  type          = "EC2_LINUX"

  tags = {
    Name        = "karpenter-nodes"
    Environment = var.environment
  }
}
