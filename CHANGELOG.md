# Changelog

All notable changes to this project will be documented in this file.

## [0.1.21]() (2024-12-24)

### Features

* AWS EKS-Helm Metrics Server: Init module. [(./aws/eks-helm/metrics-server)](./aws/eks-helm/metrics-server)
* AWS EKS-RBAC: Init module. [(./aws/eks-rbac)](./aws/eks-rbac)
* AWS SES: Rename `use_route53` to `verify_domain` and add prefix `_amazonses.` to route53 record to validate SES domain. [(./aws/ses)](./aws/ses)
* AWS OIDC provider: refactor and generalized [(./aws/github-oidc/modules/provider)]() to dedicated module at [(./aws/oidc/provider)](./aws/oidc/provider).
* AWS Jenkins OIDC: Init jenkins-oidc module. [(aws/oidc/jenkins-oidc)](./aws/oidc/jenkins-oidc)
* AWS GitHub OIDC: [(aws/oidc/github-oidc)](./aws/oidc/github-oidc)
  * Add provider `tls` version constraints.
  * Replace `var.aws_account_id` with `data.aws_caller_identity` to use runtime AWS identity.
  * Add variables: `additional_thumbprints`, `client_id_list`, `url`, `create_provider`.
  * Add outputs: `provider_arn`, `provider_url`, `github_tf_ops_role_arn`.

## [0.1.20]() (2024-12-24)

### Features

* AWS eks-helm/aws-load-balancer-controller: init module [(./aws/eks-helm/aws-load-balancer-controller)](./aws/eks-helm/aws-load-balancer-controller/)
* AWS SQS [(./aws/sqs)](./aws/sqs)
  * Refactor components.
  * Update policies Send Receive resources principal to created queue only.
  * Update policy Receive with 2 additional permissions: `sqs:DeleteMessage`, `sqs:GetQueueAttributes`.
  * Remove redundant policy in `aws_sqs_queue.queue`.

## [0.1.19]() (2024-12-23)

### Features

* AWS eks-cluster [(./aws/eks-cluster)](./aws/eks-cluster/)
  * Add output `datadog_agent_cluster_role_name`
  * Update assume policy of eks-node-cluster from `eks.amazonaws.com` to `ec2.amazonaws.com`

## [0.1.18]() (2024-12-23)

### Features

* AWS S3: add output: `iam_policy_s3_bucket_assets_read_write_arn`. [(./aws/s3)](./aws/s3/)

## [0.1.17]() (2024-12-23)

### Features

* AWS KMS: Update key policy statement [(./aws/kms)](./aws/kms).
* AWS static-website: Update `aws_cloudfront_distribution.aliases`. Add variable `domain_name`, `enabled_read_write_policy`, `enabled_read_only_policy`. [(./aws/static-website)](./aws/static-website).

## [0.1.16]() (2024-12-20)

### Features

* AWS Cloudwatch Alarm: Add support for specifying target group in alarms [(./aws/cloudwatch/alarm)](./aws/cloudwatch/alarm).

### Fix Bugs
* AWS KMS: Add policy `kms:PutKeyPolicy` to fix cannot apply because of error KMS: PutKeyPolicy [(./aws/kms)](./aws/kms)

## [0.1.15]() (2024-12-19)

### Features

* Add AWS Cloud Trail module [(./aws/cloudtrail)](./aws/cloudtrail).
* AWS Postgres: Update security group to use vpc existing security groups and allow user to overwrite rds parameter group name.
* AWS KMS: Change from `aws_iam_policy.this[*].arn` to `values(aws_iam_policy.this)[*].arn` in order to fix the null list output.
* AWS S3: Add variable `acl` and resource `aws_s3_bucket_acl`.

## [0.1.14]() (2024-12-18)

### Features

* AWS Postgre: Add `var.db_identifier` and update `identifier` naming logic from modules `main_db_instance` and `replica_db_instance`. Add `var.copy_tags_to_snapshot`. [(./aws/postgres)](./aws/postgres)
* AWS VPC: Add variables: `create_custom_subnets`, `custom_public_subnets`, `custom_private_subnets` and update subnet creation logics. Correct `aws_security_group.allow_all_within_vpc` ingress rule `cidr_blocks`. Remove `environment` from resource tags.[(./aws/vpc)](./aws/vpc)
* AWS Route53: Add `r53_main_name_servers` output for route53 [(./aws/route53)](./aws/route53)

## [0.1.13]() (2024-12-17)

### Features

* OpenVPN: Add Ignore Change for `ami` and `user_data` [(./aws/openvpn)](./aws/openvpn)

## [0.1.12]() (2024-12-17)

### Features

* Add AWS GitHub OIDC [(./aws/github-oidc)](./aws/github-oidc)
* Update output for AWS Route53 [(./aws/route53)](./aws/route53)
* Add `read_write_policy` and attributes `force_destroy` for AWS S3  [(./aws/s3)](./aws/s3)
* Update policy for AWS KMS [(./aws/kms)](./aws/kms)
* Update AWS ACM `var.zone_id` default value to `null` and resource conditions [(./aws/acm)](./aws/acm)

## [0.1.11]() (2024-16-09)

### Features

* Add CloudWatch Alarm Module(./aws/cloudwatch/alarm)

## [0.1.10]() (2024-12-12)

### Features

* Add Github Actions Module

## [0.1.9]() (2024-12-09)

### Fixed Bugs

#### aws/kms

* Refactored the module to ensure it will not create excessive resources.

## [0.1.8]() (2024-12-09)

### Fixed Bugs

#### aws/scheduler

* Refactored the module to ensure tasks are reliably executed from other services.

## [0.1.7]() (2024-12-08)

### Fixed Bugs

#### aws/ses

* Fixed a bug for the SES policy to send the email.

## [0.1.6]() (2024-12-08)

### Fixed Bugs

#### gcp/service-config

* Fixed a bug where the output `dns_record_name` could be null if the `managed_zone` was not specified.
* Fixed a bug that prevented the creation of the DNS record set due to an incorrect DNS name value.

## [0.1.5]() (2024-12-06)

### Features

* Add GCP Service Connection Policies Module
* Add GCP IAM Member Module
* Add GCP Workspace Module
* Add GCP Ingress Module
* Add GCP Service Config
* Add GCP Workload Identity
* Add GCP Storage Bucket
* Add GCP Project Service
* Add GCP OpenVPN Module
* Add AWS OpenVPN Module

## [0.1.4]() (2024-12-06)

### Features

* Add Wildcard SSL Cert module

## [0.1.3]() (2024-12-05)

### Features

* Add GCP Github OIDC
* Add GCP GKE Gateway API module
* Add GCP Service Account module
* Add AWS Eventbridge Scheduler module
* Add AWS SES module

## [0.1.2]() (2024-12-04)

### Features

* Add KMS module
* Update Static website module, with default behaviors

## [0.1.1]() (2024-11-29)

### Features

* Update postgres module

## [0.1.0]() (2024-11-28)

### Features

* Add AWS acm, alb, amplify, ecr, ecs-application, ecs-cluster, elasticache, iam-sso, identity-provider, opensearch,
  password-generator, postgres, route53, s3, sqs, ssm-parameter, static-website, vpc-endpoints, vpc, vpn modules.
