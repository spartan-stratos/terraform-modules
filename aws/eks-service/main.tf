locals {
  service_account_name = "default"
}

data "aws_lb_hosted_zone_id" "this" {
  region = var.region
}

# Check if the namespace exists
data "kubernetes_namespace_v1" "existing" {
  metadata {
    name = var.service.namespace
  }
}

data "aws_iam_policy_document" "this" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type        = "Federated"
      identifiers = [var.eks_oidc_provider.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.eks_oidc_provider.url}:sub"

      values = [
        "system:serviceaccount:${var.service.name}:${local.service_account_name}"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.eks_oidc_provider.url}:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }
  }
}

resource "kubernetes_namespace" "this" {
  count = try(data.kubernetes_namespace_v1.existing.metadata.0.name) != var.service.namespace || var.create_kubernetes_namespace ? 1 : 0

  metadata {
    name = var.service.namespace
  }
}

resource "kubernetes_config_map" "this" {
  depends_on = [kubernetes_namespace.this]
  metadata {
    name      = var.config_map_name != null ? var.config_map_name : "${var.service.name}-config-map"
    namespace = var.service.namespace
  }

  data = var.service.config_map != null ? var.service.config_map : {}
}

resource "kubernetes_secret" "this" {
  depends_on = [kubernetes_namespace.this]
  metadata {
    name      = var.secret_env_var_name != null ? var.secret_env_var_name : "${var.service.name}-env-var"
    namespace = var.service.namespace
  }

  data = var.service.secrets

  type = "Opaque"
}

resource "aws_route53_record" "this" {
  for_each = toset(var.service.hostnames)
  name     = each.key
  type     = "A"
  zone_id  = var.route53_zone_id

  alias {
    zone_id                = data.aws_lb_hosted_zone_id.this.id
    name                   = var.alb_dns
    evaluate_target_health = true
  }
}

resource "aws_iam_role" "this" {
  name = "${var.cluster_name}-${var.service.name}-eksPodRole"

  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = length(var.service.additional_iam_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = var.service.additional_iam_policy_arns[count.index]
}

resource "kubernetes_annotations" "default" {
  depends_on  = [kubernetes_namespace.this]
  api_version = "v1"
  kind        = "ServiceAccount"
  metadata {
    name      = local.service_account_name
    namespace = var.service.namespace
  }
  annotations = {
    "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
  }
}
