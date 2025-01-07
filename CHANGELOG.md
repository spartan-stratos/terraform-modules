# Changelog

All notable changes to this project will be documented in this file.

## [0.1.37]() (2025-01-06)
### Features
* AWS SQS: [(./aws/sqs)](./aws/sqs)
  * Add variable `enabled_dead_letter_queue` to optionally disable dlq
  * Add variable `enabled_read_write_policy` and `read_write_policy_name` to optionally configure a read-write policy
* AWS StaticWebsite/Cloudfront: [(./aws/static-website/modules/cloudfront/)](./aws/static-website/modules/cloudfront/)
  * Add `override.tofu` to override Terraform version constrain with OpenTofu
* AWS OIDC/Jenkins: [(./aws/oidc/jenkins-oidc)](./aws/oidc/jenkins-oidc/)
  * Fix `for_each argument must be a map, or set of strings`: wrap the argument in `toset`

## [0.1.36]() (2025-01-05)
### Features
* Datadog aws-monitor: [(./datadog/aws-monitor)](./datadog/aws-monitor/)
  * Remove unused variables `dd_users`.
* Datadog monitors: [(./datadog/monitors)](./datadog/monitors/)
  * Add monitor_thresholds.ok and customize query type.
* Datadog mono-monitor: Init module [(./datadog/mono-monitor)](./datadog/mono-monitor/)
* Datadog service-monitor: Init module [(./datadog/service-monitor)](./datadog/service-monitor/)
* AWS S3: Add variables to overwrite policy name: `custom_readonly_policy_name`, `custom_read_write_policy_name` [(./aws/s3)](./aws/s3/)

## [0.1.35]() (2025-01-03)
### Features 
* All modules: add an `override.tofu` file to override terraform version constraint to opentofu version constraint
* AWS eks-cluster: [(./aws/eks-cluster)](./aws/eks-cluster/)
  * Update provider urls (remove `registry.terraform.io`) in order for OpenTofu to map to their registry.

## [0.1.34]() (2025-01-02)
### Features 
* AWS Jenkins OIDC: [(./aws/oidc/jenkins-oidc)](./aws/oidc/jenkins-oidc/)
  * Add provider `custom_oidc_policy_statement` to customize oidc policy statement.
  * Add `var.oidc_policy_name` and `var.oidc_policy_description` to overwrite the existed default name and description
* AWS Jenkins: [(./aws/eks-helm/jenkins)](./aws/eks-helm/jenkins)
  * Add variable `jenkins_config_map_name` to use configMapRef in containerEnvFrom
  * Add variable `jenkins_viewer` to add permission for GitHub team groups that defined in jenkins viewer

## [0.1.33]() (2025-01-02)
### Features 
* AWS Cloudwatch Alarm [(./aws/cloudwatch/alarm)](./aws/cloudwatch/alarm)
  * Ensure InstanceId is included when the namespace is "AWS/EC2".
* AWS OpenVPN [(./aws/openvpn)](./aws/openvpn)
  * Add outputs for EC2 instance.
  * Introduced `http_tokens` and `http_endpoint` variables to control instance metadata service settings.
* AWS Security Groups [(./aws/security-group)](./aws/security-group)
  * Updated the logic to set from_port and to_port to -1 when the IP protocol is "-1", ensuring compatibility for security group rules with all protocols.

## [0.1.32]() (2024-12-31)
### Fixes
* Datadog / AWS-Monitors: [(./datadog/aws-monitors)](./datadog/aws-monitors)
  * Add a default value for Terraform try functions

## [0.1.31]() (2024-12-31)

### Features
* AWS Helm / Jenkins: [(./aws/eks-helm/jenkins)](./aws/eks-helm/jenkins)
  * Init module with all the code
* Datadog / Monitors: [(./datadog/monitors)](./datadog/monitors)
  * Init module with all the code
* Datadog / AWS-Monitors: [(./datadog/aws-monitors)](./datadog/aws-monitors)
  * Init module with all the code

### Fixes
* AWS OpenVPN: [(./aws/openvpn/)](./aws/openvpn/)
  * Add missing a new line in the init script template

## [0.1.30]() (2024-12-30)

### Features
* AWS OpenVPN: [(./aws/openvpn/)](./aws/openvpn/)
  * Add a flag to determine whenever to recreate OpenVPN instance when there is update in some variables: `replace_instance_on_update`.
* AWS Security Group: [(./aws/security-group/)](./aws/security-group/)
  * Update Security Group Resources to Support Dynamic Ingress and Egress Rule Management
* Qdrant: [(./qdrant)](./qdrant)
  * Initial commit with all the code

## [0.1.29]() (2024-12-30)

### Features
* AWS VPC: Add private database subnet groups [(./aws/vpc)](./aws/vpc/)
* AWS VPC Endpoints: * Add support for EKS VPC endpoint configuration [(./aws/vpc-endpoints)](./aws/vpc-endpoints/)
* AWS Security Group: Add variable `custom_sg_allow_all_within_vpc_egress_ipv6_cidr_blocks` to avoid update sg during migration [(./aws/security-group)](./aws/security-group/)

## [0.1.28]() (2024-12-27)

### Features
* AWS Static Website: [(./aws/static-website)](./aws/static-website/)
  * Add a flag to enable www domain: `use_www_domain`
  * Add `cloudfront_distribution_aliases` variable to custom distribution aliases
  * Add `existing_s3_bucket_name` variable to specify the name of custom s3 bucket to use
* AWS OpenVPN: [(./aws/openvpn)](./aws/openvpn/)
  * Allow using this module to use various available OAuth2 provider by adding variables: `oauth2_provider`, `oauth2_issuer`
  * Allow validate group and role of the authorized identity via `oauth2_validate_groups` and `oauth2_validate_roles`
  * Make management ssh key optional `create_management_key_pair`
  * And add some variables for migrations: `custom_cert_dns_names`, `create_egress_vpn_rule`, `init_script_callback_comment`
* AWS SQS: [(./aws/sqs)](./aws/sqs/)
  * Make read/write policy's name customizable via variables `read_policy_name` and `write_policy_name`.

## [0.1.27]() (2024-12-26)

### Features
* AWS S3: [(./aws/s3)](./aws/s3)
  * Add variables to avoid forced resource replacements during rollout: `read_write_policy_description`, `read_write_policy_name_prefix`, `readonly_policy_description`, `readonly_policy_name_prefix`, `public_policy_description`, and `public_policy_name_prefix`.
* AWS Security Groups: Add variable `custom_sg_allow_all_within_vpc_egress_ipv6_cidr_blocks` to avoid update sg during migration [(./aws/security-group)](./aws/security-group)

## [0.1.26]() (2024-12-26)

### Features
* AWS EKS Service: Add output `service_hostnames` to generates a map of service hostnames by iterating over the Route 53 records and extracting their fully qualified domain names (FQDNs) [(./aws/eks-service)](./aws/eks-service)

## [0.1.25]() (2024-12-26)

### Features
* AWS Security Group: Add variables: custom_sg_allow_all_description and custom_sg_allow_all_within_all_description to avoid forces replacement during migration. [(./aws/security-group)](./aws/security-group)

## [0.1.24]() (2024-12-26)

### Features
* AWS EKS Service: [(./aws/eks-service)](./aws/eks-service)
  * Add `var.create_kubernetes_namespace` to specify whether to create a namespace
  * Add `var.config_map_env_var_name` to overwrite default kubernetes_config_map name
  * Add `var.secret_env_var_name` to overwrite default kubernetes_secret secret env var name
* AWS Elasticache: [(./aws/elasticache)](./aws/elasticache)
  * Add output `elasticache_replication_group_configuration_endpoint_address`. 
* AWS S3: [(./aws/s3)](./aws/s3)
  * Add attribute `expose_headers` to variable `cors_configuration`.

## [0.1.23]() (2024-12-26)

### Features

* AWS Security Group: Introduce functionality to create default security groups with configurable CIDR blocks and VPC ID.
* AWS GuardDuty: Init module.

## [0.1.22]() (2024-12-25)

### Features

* AWS EKS-Service: Init module. [(./aws/eks-service)](./aws/eks-service)
* AWS EKS-Helm / Datadog: Init module. [(./aws/eks-helm/datadog)](./aws/eks-helm/datadog)
* AWS Amplify: [(./aws/amplify)](./aws/amplify)
  * Add `var.enable_backend` to enable backend or use frontend format only
  * Add `aws_amplify_webhook` to provides an Amplify Webhook resource
* AWS VPC: [(./aws/vpc)](./aws/vpc)
  * Separate the VPC and Security Group
  * Introduced a conditional mechanism to control the creation of VPC flow logs.
* Datadog/AWS Integration: Init module. [(./datadog/aws-integration)](./datadog/aws-integration)
* Datadog/GCP Integration: Init module. [(./datadog/gcp-integration)](./datadog/gcp-integration)
* AWS Postgres: Add `var.publicly_accessible` to allow external machine connect to rds if `true` [(./aws/postgres)](./aws/postgres)

### Fixes
* AWS Postgres: Correct conditions to create security group `aws_security_group.this` when variable `vpc_security_group_ids` is null [(./aws/postgres)](./aws/postgres)

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
