/*
aws_opensearch_domain provisions an Amazon OpenSearch Service domain, configuring cluster, storage, and network settings.
The `domain_name`, `engine_version`, instance configuration, and security settings are specified by variables to enable customization.
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearch_domain
*/
resource "aws_opensearch_domain" "this" {
  domain_name    = var.domain
  engine_version = var.engine_version
  cluster_config {
    instance_type  = var.instance_size
    instance_count = var.instance_count
  }
  vpc_options {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_size = var.ebs_storage_size
  }
  access_policies = data.aws_iam_policy_document.this.json
}
