locals {
  # 1.9.2 => ["1", "9", "2"]
  chart_version_parts = split(".", var.aws_load_balancer_controller_chart_version)

  # 1.9.2 => v2.9
  policy_document_version = "v2.${local.chart_version_parts[1]}"

  policy_file = "${path.module}/policies/AWSLoadBalancerControllerIAMPolicy-${local.policy_document_version}.json"
}
