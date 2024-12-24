/**
Generates an IAM policy document in JSON format.
This block generates required assume role actions to provider.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
 */
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    principals {
      type        = "Federated"
      identifiers = [module.provider.arn]
    }
  }
}

/**
This block provides an IAM role to Jenkins OIDC.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
 */
resource "aws_iam_role" "oidc" {
  name               = var.role_name_prefix == "" ? "${var.role_name}" : "${var.role_name_prefix}-${var.role_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

/**
Generates an IAM policy document in JSON format.
This block generates required actions for Jenkins.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
 */
data "aws_iam_policy_document" "oidc" {
  statement {
    effect = "Allow"
    actions = [
      "cloudfront:CreateInvalidation"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:GetBucketLocation"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "eks:DescribeCluster",
      "eks:ListClusters",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:DescribeRepositories",
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ssm:PutParameter",
      "ssm:DeleteParameter",
      "ssm:GetParametersByPath",
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:DeleteParameters"
    ]
    resources = ["*"]
  }
}

/**
This block create an IAM policy for Jenkins OIDC to access AWS resources.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
 */
resource "aws_iam_policy" "oidc" {
  name   = "jenkins_oidc_policy"
  policy = data.aws_iam_policy_document.oidc.json
}

/**
This block create a policy attachment to Jenkins OIDC role.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
 */
resource "aws_iam_role_policy_attachment" "oidc" {
  depends_on = [aws_iam_policy.oidc]

  role       = aws_iam_role.oidc.name
  policy_arn = aws_iam_policy.oidc.arn
}
