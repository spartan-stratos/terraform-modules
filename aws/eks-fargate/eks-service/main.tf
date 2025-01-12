locals {
  service_account_name = "default"
}

data "aws_lb_hosted_zone_id" "this" {
  region = var.region
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
  for_each = var.services

  metadata {
    name = each.value.namespace
  }
}


resource "kubernetes_config_map" "this" {
  for_each = var.services

  metadata {
    name      = "${each.key}-config-map"
    namespace = each.value.namespace
  }

  data = each.value.config_map != null ? each.value.config_map : {}
}

resource "kubernetes_secret" "this" {
  for_each = var.services

  metadata {
    name      = "${each.key}-env-var"
    namespace = each.value.namespace
  }

  data = each.value.secrets

  type = "Opaque"
}

resource "aws_route53_record" "this" {
  for_each = toset(flatten([for service, values in var.services : values.hostnames]))
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
  for_each = var.services

  name               = "${var.cluster_name}-${each.key}-eksPodRole"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = length(var.services.additional_iam_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = var.services.additional_iam_policy_arns[count.index]
}

resource "kubernetes_annotations" "this" {
  for_each = var.services

  api_version = "v1"
  kind        = "ServiceAccount"
  metadata {
    name      = local.service_account_name
    namespace = each.value.namespace
  }
  annotations = {
    "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
  }
}
