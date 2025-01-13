locals {
  service_account_name = "default"
}

data "aws_lb_hosted_zone_id" "this" {
  region = var.region
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
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Federated": "${var.eks_oidc_provider.arn}"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
            "StringEquals": {
                "${var.eks_oidc_provider.url}:sub": "system:serviceaccount:${each.key}:${local.service_account_name}",
                "${var.eks_oidc_provider.url}:aud": "sts.amazonaws.com"
            }
        }
    }
  ]
}
EOF
}

// Extracting the additional IAM policy mappings into a separate variable for better readability
# Flatten the nested loop logic into a local variable for readability
locals {
  iam_policy_attachments = tomap({
    for service, service_configuration in var.services :
    service => [
      for policy_arn in service_configuration.additional_iam_policy_arns :
      {
        service    = service.name
        policy_arn = policy_arn
      }
      if length(service_configuration.additional_iam_policy_arns) > 0
    ]
  })
}

# Flatten the list of policies and add a unique key for each
resource "aws_iam_role_policy_attachment" "this" {
  for_each = {
    for service, policies in local.iam_policy_attachments :
    service => policies
  }

  role       = aws_iam_role.this[each.value.service].name
  policy_arn = each.value.policy_arn
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
    "eks.amazonaws.com/role-arn" = aws_iam_role.this[each.key].arn
  }
}
