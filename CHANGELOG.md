# Changelog

All notable changes to this project will be documented in this file.

## [0.6.7]() (2025-06-10)

### Features

* AWS Static-website [(./aws/static-website)](./aws/static-website)
    * Add output `cloudfront_distribution_arn`.

## [0.6.6]() (2025-06-06)

### Features

* AWS RDS [(./aws/rds)](./aws/rds)
    * Add `enabled_cloudwatch_logs_exports` to enable logging on RDS instance and replicas.Add commentMore actions
      Add comment

* AWS CloudTrail [(./aws/cloudtrail)](./aws/cloudtrail)
    * Add CloudTrail CloudWatch integrations to deliver CloudTrail logs to CloudWatch.

## [0.6.5]() (2025-06-03)

### Features

* AWS Static Website [(./gcp/storage-bucket)](./gcp/storage-bucket)

    * Add `lifecycle_rules` and `soft_delete_policy`.
    * Add `logging` to define destination bucket for storing access logs.
    * Add `enable_creator_policy` to add permission for log bucket to create log objects.

## [0.6.4]() (2025-06-03)

### Removed

* AWS Static Website [(./aws/static-website)](./aws/static-website)
    * Removes duplicate S3 bucket policy creation in [./aws/static-website/s3.tf](./aws/static-website/s3.tf).

## [0.6.3]() (2025-06-02)

### Changes

* AWS Static Website [(./aws/static-website)](./aws/static-website)
    * Enable HTTP access for S3 bucket in CloudFront setup.

## [0.6.2]() (2025-06-01)

### ⚠ BREAKING CHANGES

* AWS Opensearch [(./aws/opensearch)](./aws/opensearch)
    * Add `enforce_https` and `tls_security_policy` to enforce HTTPS.

### Features

* GCP Logging metric [(./gcp/google-monitoring/logging-metric)](./gcp/google-monitoring/logging-metric)
* GCP monitoring notification
  channel [(./gcp/google-monitoring/monitoring-notification-channel)](./gcp/google-monitoring/monitoring-notification-channel)

### Changes

* AWS RDS [(./aws/rds)](./aws/rds)
    * Add `db_port` output to RDS module.

## [0.6.1]() (2025-05-27)

### Changes

* AWS ElastiCache [(./aws/elasticache)](./aws/elasticache)
    * Replaced hardcoded Redis engine with a variable to support different cache gines, such as Redis or Valkey.

## [0.6.0]() (2025-05-27)

### ⚠ BREAKING CHANGES

* GCP Storage bucket: [(./gcp/storage-bucket)](./gcp/storage-bucket)
    * Separate permissions of Google Cloud Storage bucket and objects: Add `is_listable` variable to manage bucket
      permission, allow `allUsers` to list object. `is_public` variable allow `allUsers` to get object as usual.

### Features

* AWS RDS: [(./aws/rds)](./aws/rds)
    * Add variable `primary_deletion_protection` and `replica_deletion_protection` to manage `deletion_protection`
      status on primary and replicas.

## [0.5.4]() (2025-05-22)

### Features

* AWS OPA module: [(./aws/eks-helm/opa)](./aws/eks-helm/opa)
    * Add OPA helm deployment module

## [0.5.3]() (2025-05-13)

### Features

* AWS EKS: Helm Jenkins [(./aws/eks-helm/jenkins)](./aws/eks-helm/jenkins)
    * Add `nodejs_configuration` to customize nodejs version in case projects need the latest version nodejs.
    * Add `tolerations` and `node_selectors` for scheduling jenkins on managed node or fargate

### Changes

* AWS EKS: Helm Jenkins [(./aws/eks-helm/jenkins)](./aws/eks-helm/jenkins)
    * Update credential plugins version, which is the reason that cause crash for jenkins

## [0.5.2]() (2025-04-25)

### Features

* AWS Postgres [(./aws/postgres)](./aws/rds)
    * Add variable `multi-az` to indicate whether the database instance should be deployed across multiple availability
      zones

## [0.5.1]() (2025-04-24)

### ⚠ BREAKING CHANGES

* DataDog Service Monitor: [(./datadog/service-monitor)](./datadog/service-monitor)
    * Modify the Datadog restart monitor to use the diff function, which captures only new restart events. When a pod
      restarts, the query returns a value of 1, and it falls back to 0 if no further restarts occur.

## [0.5.0]() (2025-04-21)

### ⚠ BREAKING CHANGES

* AWS ALB : [(./aws/alb)](./aws/alb)
    * Add flag `enable_http_port` to add or ignore HTTP port 80 on security group and ALB listener.
* AWS Openvpn: [(./aws/openvpn)](./aws/openvpn)
    * Add variable `enabled_http_port` to make HTTP optional from security group.

### Features

* AWS VPC: [(./aws/vpc)](./aws/vpc)
    * Add VPC Network ACLs rules with variable `custom_acls`.

## [0.4.4]() (2025-04-18)

### Fix Bugs

* AWS EKS Helm ArgoCD: [(./aws/eks-helm/argocd)](./aws/eks-helm/argocd)
    * Fix the in_cluster_name issue

## [0.4.3]() (2025-04-18)

### Features

* AWS EKS Helm ArgoCD: [(./aws/eks-helm/argocd)](./aws/eks-helm/argocd)
    * Add Route53 record

### Fix Bugs

* AWS EKS Helm ArgoCD: [(./aws/eks-helm/argocd)](./aws/eks-helm/argocd)
    * Fix the namespace argocd is not found
    * Fix the no policy define in the role_policy
    * Fix the Ingress annotation to create the ALB listener rules

## [0.4.2]() (2025-04-17)

### Features

* AWS EKS Helm ArgoCD: [(./aws/eks-helm/argocd)](./aws/eks-helm/argocd)
    * Change variables that defined in `camelCase` to `snake_case`
    * `var.external_cluster`
        * assumeRoles -> assume_role
        * clusterResources -> cluster_resources
        * awsAuthConfig -> aws_auth_config
        * clusterName -> cluster_name
        * roleARN -> role_arn
        * tlsClientConfig -> tls_client_config
        * caData -> ca_data
    * Add variable `enabled_managed_in_cluster` to enable in_cluster management, and `in_cluster_name` to change its
      name when `enabled_managed_in_cluster` is enable

## [0.4.1]() (2025-04-16)

### Features

* AWS Elasticache: [(./aws/elasticache)](./aws/elasticache)
    * Add `custom_redis_parameters` to add the custom redis configuration.

## [0.4.0]() (2025-04-16)

### ⚠ BREAKING CHANGES

* AWS S3: [(./aws/s3)](./aws/s3)
    * Update `aws_s3_bucket_policy` with creation flag `create_bucket_policy`.

## [0.3.17]() (2025-04-16)

### Features

* AWS S3: [(./aws/s3)](./aws/s3)
    * Add S3 lifecycle configuration `s3_lifecycle_rules`.

## [0.3.16]() (2025-04-14)

### Features

* AWS Static website: [(./aws/static-website)](./aws/static-website)
    * Add `use_wildcard_domain` to support add route53 wildcard to our cloudfront

* AWS OpenSearch: [(./aws/opensearch)](./aws/opensearch)
    * Add `availability_zone_count` and `zone_awareness_enabled` to enable multi-az

## [0.3.15]() (2025-04-11)

### Features

* AWS KMS: [(./aws/kms)](./aws/kms)
    * Add statements to KMS policy via `additional_statements`.

* AWS EKS Helm ArgoCD: [(./aws/eks-helm/argocd)](./aws/eks-helm/argocd)
    * Add predefined group rules for projects.
    * Update destinations for projects and root applications
    * Update the condition for adding in-cluster and rename it

### Bug Fixes

* AWS Helm Nginx Ingress
  Controller: [(./aws/eks-helm/nginx-ingress-controller)](./aws/eks-helm/nginx-ingress-controller)
    * Update replicas variable name

## [0.3.14]() (2025-04-11)

### Features

* AWS Cloudtrail: [(./aws/cloudtrail)](./aws/cloudtrail)
    * Restrict HTTP access to S3 bucket via `disabled_s3_http_access`.

* AWS s3: [(./aws/s3)](./aws/s3)
    * Restrict HTTP access to S3 bucket via `disabled_s3_http_access`.

### Bug Fixes

* AWS Helm Nginx Ingress
  Controller: [(./aws/eks-helm/nginx-ingress-controller)](./aws/eks-helm/nginx-ingress-controller)
    * Update replicas variable name

## [0.3.13]() (2025-04-10)

### Features

* Add RDS namespace `identifier`.

## [0.3.12]() (2025-04-10)

### Features

* AWS EKS Helm ArgoCD: [(./aws/eks-helm/argocd)](./aws/eks-helm/argocd)
    * Add annotations for adding new roles

### Fix Bugs

* AWS EKS Helm ArgoCD: [(./aws/eks-helm/argocd)](./aws/eks-helm/argocd)
    * Fix Github Repository Connection
    * Fix projects permission
    * Update OIDC arn to OIDC url for cluster connection

## [0.3.11]() (2025-04-09)

### Features

* Add `nginx-ingress-controller` module

## [0.3.10]() (2025-04-09)

### Bug Fixes

* Add `replicas_per_node_group` to support multi-az.

## [0.3.9]() (2025-04-09)

### Features

* AWS EKS Cluster: [(./aws/eks-cluster)](./aws/eks-cluster)
    * Add some configuration to enable EFS CSI on ManagedNodeGroup
        * nodeSelector
        * tolerations
        * AWS IRSA

## [0.3.8]() (2025-04-08)

### Features

* AWS EKS Helm ArgoCD: [(./aws/eks-helm/argocd)](./aws/eks-helm/argocd)
    * Update Ingress and OIDC Connection
    * Add `issuer_url` for dex config

* AWS Elasticache: [(./aws/elasticache)](./aws/elasticache)
    * Add `transit_encryption_mode` to `aws_elasticache_replication_group`.

* AWS Static Website: [(./aws/static-website)](./aws/static-website)
    * Add `s3_redirect_domain` to configure addressed S3 bucket to redirect to another domain

* AWS OpenSearch: [(./aws/opensearch)](./aws/opensearch)
    * Add `encrypt_at_rest_enabled` to enable encryption of data at rest.

## [0.3.7]() (2025-04-04)

### Fix Bugs

* AWS EKS Helm AWS Load Balancer
  Controller: [(./aws/eks-helm/aws-load-balancer-controller)](./aws/eks-helm/aws-load-balancer-controller)
    * Update policies and add require permission to those

## [0.3.6]() (2025-04-04)

### Fix Bugs

* AWS EKS Helm ArgoCD [(./aws/eks-helm/argocd)](./aws/eks-helm/argocd)
    * Add tolerants which will schedule argocd to managed node

## [0.3.5]() (2025-04-04)

### Fix Bugs

* AWS EKS Helm ArgoCD [(./aws/eks-helm/argocd)](./aws/eks-helm/argocd)
    * Remove those attributes when creating helm argocd
    ```hcl
    wait             = true
    timeout          = 300
    ```

## [0.3.4]() (2025-04-03)

### Features

* AWS Elasticache [(./aws/elasticache)](./aws/elasticache)
    * Add `at_rest_encryption_enabled`.

## [0.3.3]() (2025-04-03)

### Features

* AWS EKS Helm ArgoCD [(./aws/eks-helm/argocd)](./aws/eks-helm/argocd)
    * Update provider version
    * Split CRDs include `Projects` and `Applications` to a single sub-module, which will handle creating Projects and
      Applications.

## [0.3.2]() (2025-04-01)

### Features

* AWS EKS Helm ArgoCD [(./aws/eks-helm/argocd)](./aws/eks-helm/argocd)

## [0.3.1]() (2025-03-31)

### Features

* AWS EKS Helm Keycloak [(./aws/eks-helm/keycloak)](./aws/eks-helm/keycloak)

## [0.3.0]() (2025-03-30)

### Features

* AWS EKS Access Entry: [(./aws/eks-access-entry)](./aws/eks-access-entry)
    * Use the inline EKS Access Entry

* AWS EKS Cluster: [(./aws/eks-cluster)](./aws/eks-cluster)
    * Add the labels for managed_nodes

* AWS EKS Helm Keda [(./aws/eks-helm/keda)](./aws/eks-helm/keda)
    * Add the labels and tolerations

* AWS EKS Helm Datadog [(./aws/eks-helm/datadog)](./aws/eks-helm/datadog)
    * Add the labels and tolerations

* AWS EKS Helm Metrics Server [(./aws/eks-helm/metrics-server)](./aws/eks-helm/metrics-server)
    * Add the labels and tolerations

* AWS EKS Helm Neo4j [(./aws/eks-helm/neo4j)](./aws/eks-helm/neo4j)
    * Add the labels and tolerations

## [0.2.6]() (2025-03-29)

### Features

* AWS EKS Service: [(./aws/eks-service)](./aws/eks-service)
    * Add inline k8s service account annotations

## [0.2.5]() (2025-03-18)

### Features

* AWS ECS application: [(./aws/ecs-application)](./aws/ecs-application)
    * Allow all connection within VPC to container port if `enabled_service_connect` set to `true`.

## [0.2.4]() (2025-03-18)

### Bug Fixes

* AWS ECS application: [(./aws/ecs-application)](./aws/ecs-application)
    * Add object attribute `name` to variable `additional_port_mappings`.

## [0.2.3]() (2025-03-18)

### Features

* AWS ECS application: [(./aws/ecs-application)](./aws/ecs-application)
    * Add variable `port_mapping_name` for service connect.

## [0.2.2]() (2025-03-18)

### Features

* AWS ECS: [(./aws/ecs-cluster)](./aws/ecs-cluster)
    * Add ECS Service Connect using `enabled_service_connect`.

* AWS ECS application: [(./aws/ecs-application)](./aws/ecs-application)
    * Add ECS Service Connect using `enabled_service_connect` and `service_connect_configuration`.

## [0.2.1]() (2025-03-18)

### Features

* AWS ECS application: [(./aws/ecs-application)](./aws/ecs-application)
    * Introduces new variables:
        * `task_cpu` and `task_memory`: to define task resources, container resource defined
          by `container_cpu`, `container_memory`.
        * `cloudwatch_log_group_name`, `cloudwatch_log_group_migration_name`: to define cloudwatch log group name.
          If `cloudwatch_log_group_migration_name` is not null, it will create a log group for service migration logs.
        * `overwrite_task_role_name`, `overwrite_task_execution_role_name`, `task_policy_secrets_description`,
          `task_policy_ssm_description`:
          fallback on default value.
        * `enabled_datadog_sidecar`, `dd_site`, `dd_api_key_arn`, `dd_agent_image`, `dd_port`: supports datadog sidecar
          definitions.
        * `use_alb`: whether to use ALB.

## [0.2.0]() (2025-03-17)

### Features

* AWS Password Generator: [(./aws/password-generator)](./aws/password-generator)
    * Add variable `password_length`.

* AWS Secret Manager: [(./aws/secret-manager)](./aws/secret-manager)
    * Init module.

* AWS SendGrid: [(./aws/sendgrid)](./aws/sendgrid)
    * Init module.

## [0.1.81]() (2025-03-13)

### Features

* Datadog Dashboard: [(./datadog/dashboard)](./datadog/dashboard)
    * Init Datadog Dashboard module

* AWS SES: [(./aws/ses)](./aws/ses)
    * Add the Lambda function to log the SES Outgoing Emails to the Datadog

* AWS EKS Cluster [(./aws/eks-cluster)](./aws/eks-cluster)
    * Add support for the EFS CSI driver in EKS Managed Node Groups

## [0.1.80]() (2025-03-13)

### Features

* AWS SQS: [(./aws/sqs)](./aws/sqs)
    * Add attribute `content_based_deduplication` to `aws_sqs_queue.queue`.

### Fix Bugs

* AWS Elasticache: [(./aws/elasticache)](./aws/elasticache)
    * Remove `elasticache_cache_errors` for elasticache monitor, which was not neccessary

## [0.1.79]() (2025-03-12)

### Features

* AWS RDS: [(./aws/rds)](./aws/rds)
    * Add variable `use_secret_manager` and `secret_manager_db_password_name` to create Secret Manager for database
      password management.
    * Add variable `password_length` to custom database password length.
    * Add variable `db_subnet_group_name` for migration purpose.
    * Add variable `additional_postgres_parameters` for additional parameters on PostgreSQL instance.

### Bug fixes

* AWS RDS: [(./aws/rds)](./aws/rds)
    * Correct `copy_tags_to_snapshot` input to submodule `db_instance`.

## [0.1.78]() (2025-03-10)

### Features

* AWS ECS Application: [(./aws/ecs-application)](./aws/ecs-application)
    * Add `persistent_volume` and integrate with EFS service

### Bug fixes

* AWS EKS Cluster: [(./aws/eks-cluster)](./aws/eks-cluster)
    * Managed nodes: only add iam role policy when there is at least 1 statemenet
    * Managed nodes: don't ignore desired_size

## [0.1.77]() (2025-03-07)

### Bug fixes

* AWS EKS Cluster: [(./aws/eks-cluster)](./aws/eks-cluster)
    * Fix map is mapping to a non-list, which failed when create clusterrolebinding

## [0.1.76]() (2025-03-07)

### Features

* AWS EKS Cluster: [(./aws/eks-cluster)](./aws/eks-cluster)
    * Add `service_accounts` variables to handle custom service accounts

## [0.1.75]() (2024-03-07)

### Features

* AWS RDS: [(./aws/rds)](./aws/rds)
    * Rename module to `rds`
    * Rewrite the code to support multiple RDS engines

### Bug fixes

* AWS EKS Helm: [(./aws/eks-helm)](./aws/eks-helm)
    * add the wafv2 arn acl config for load balancer

* AWS EKS Cluster: [(./aws/eks-cluster)](./aws/eks-cluster)
    * Remove AmazonEKS_CNI_IPv6_Policy policy and policy attachments

## [0.1.74]() (2024-03-06)

### Bug fixes

* AWS EKS Cluster: [(./aws/eks-cluster)](./aws/eks-cluster)
    * Correct taints type.

## [0.1.73]() (2024-03-06)

### Features

* AWS EKS Service: [(./aws/eks-service)](./aws/eks-service)
    * Add the flag to customize the service account for each service.

## [0.1.72]() (2024-03-05)

### Features

* AWS WAFv2: [(./aws/wafv2)](./aws/wafv2)
    * Introduced a new module for managing AWS WAFv2 configurations.
    * Add wafv2 arn variable to allow the user to specify the WAFv2 ARN.

## [0.1.71]() (2024-03-03)

### Bug fixes

* AWS EKS Service: [(./aws/eks-service)](./aws/eks-service)
    * Fix EKS service account namespace reference

## [0.1.70]() (2024-02-27)

### Bug fixes

* AWS oidc sub module provider: [(./aws/oidc/provider)](./aws/oidc/provider)
    * Fix `aws_iam_openid_connect_provider` resource creation using `length` instead of `try` to resolve error
      that `data source is evaluated only at apply time`.

## [0.1.69]() (2025-02-21)

### Features

* AWS eks-helm Neo4j: [(./aws/eks-helm/neo4j/)](./aws/eks-helm/neo4j)
    * Add Neo4j plugin support and custom configuration options

* AWS eks-cluster: [(./aws/eks-cluster)](./aws/eks-cluster)
    * Add Managed Node Group
      module [(./aws/eks-cluster/modules/managed-node-group)](./aws/eks-cluster/modules/managed-node-group)
    * Update default cluster_version to `1.32`
    * Add tag for Managed Node Group to cluster and security group
    * Add Managed Node Group role ARNs to `aws-auth` configmap

* AWS vpc: [(./aws/vpc)](./aws/vpc)
    * Add tag for Managed Node Groups to private subnet.

## [0.1.68]() (2025-02-21)

### Features

* AWS S3: [(./aws/s3/)](./aws/s3/)
    * Add `read_write_actions` which allow s3 policy can be added permissions base on requirement of projects

### Changes

* AWS EKS: Helm Jenkins [(./aws/eks-helm/jenkins)](./aws/eks-helm/jenkins)
    * Create the credential using github_app_credential_id instead of gihub_credential_id
    * Remove unused input `gihub_credential_id`

## [0.1.67]() (2025-02-17)

### Features

* AWS ECS Application: [(./aws/ecs-application/)](./aws/ecs-application/)
    * Add flag `assign_public_ip`

## [0.1.66]() (2025-02-12)

### Features

* AWS EKS Access Entry: [(./aws/eks-access-entry/)](./aws/eks-access-entry/)
    * Updated resources dependency for improved performance
    * Added functionality to skip role creation if the role already exists

* AWS EKS Cluster: [(./aws/eks-cluster/)](./aws/eks-cluster/)
    * Enable or disable access mode dynamically in the access_config of the EKS cluster resource

* AWS GitHub Self-hosted Runner: [(./aws/github-self-hosted-runners/)](./aws/github-self-hosted-runners/)
    * Update Terraform installation to allow version suffix support

* AWS Static Website: [(./aws/static-website/)](./aws/static-website/)
    * Add response header configuration option for cloud front

## [0.1.65]() (2025-02-06)

### Features

* AWS EKS Cluster: [(./aws/eks-cluster/)](./aws/eks-cluster/)
    * Add EKS access entries and API/config map authentication options

* AWS EKS Access Entry: [(./aws/eks-access-entry/)](./aws/eks-access-entry/)
    * Init EKS access entries module

* AWS GitHub Self-hosted Runner: [(./aws/github-self-hosted-runners/)](./aws/github-self-hosted-runners/)
    * Updated configurations to utilize the new custom AMI for launch templates.

## [0.1.64]() (2025-01-24)

### Features

* AWS Static website: [(./aws/static-website/)](./aws/static-website/)
    * Allow to create the website with root domain

## [0.1.63]() (2025-01-24)

### Features

* AWS ECS Application: [(./aws/ecs-application/)](./aws/ecs-application/)
    * Refactor and remove Datadog configuration

* AWS ALB: [(./aws/alb/)](./aws/alb/)
    * Remove unused target group

## [0.1.62]() (2025-01-24)

### Features

* AWS OpenVPN: [(./aws/openvpn/)](./aws/openvpn/)
    * Make ssh rule in security group optional and disable by default, var: `allow_remote_ssh_access`

* AWS Cloudwatch/Alarm: [(./aws/cloudwatch/alarm/)](./aws/cloudwatch/alarm/)
    * Extended CloudWatch alarm configuration to support EC2 AutoScalingGroup

### Bug fixes

* AWS OpenVPN: [(./aws/openvpn/)](./aws/openvpn/)
    * Correct instance id and instance arn output

* AWS ACM: [(./aws/acm/)](./aws/acm/)
    * Fix `validation_record_fqdns` value in `aws_acm_certificate_validation`.

## [0.1.61]() (2025-01-23)

### Features

* AWS / GitHub Self-hosted Runner: [(./aws/github-self-hosted-runners/)](./aws/github-self-hosted-runners/)
    * Add variable `update_default_launch_template_version` to allowed update the default launch template version
      automatically (default = true)
    * Rename variable `vpc_zone_identifier` to `subnet_ids`

## [0.1.60]() (2025-01-22)

### Features

* Separate `keda` to 2 modules:
    * Install `Keda` and `IAM Role` [(./aws/eks-helm/keda/)](./aws/eks-helm/keda/)
    * Attach `assume_role_arns` to
      `Keda IAM Role Policy` [(./aws/eks-helm/keda/assume-role-policy/)](./aws/eks-helm/keda/assume-role-policy/))
* Update `eks-service` [(./aws/eks-service/)](./aws/eks-service/)
    * Add variable `keda_arn` to set keda irsa role arn.

## [0.1.59]() (2025-01-22)

### Features

* Enable aws billing alarm: [(./aws/cloudwatch/alarm/)](./aws/cloudwatch/alarm/)
* Add usage examples for helm modules:
    * [(./aws/eks-helm/jenkins/)](./aws/eks-helm/jenkins/)
    * [(./aws/eks-helm/datadog/)](./aws/eks-helm/datadog/)
    * [(./aws/eks-helm/metrics-server/)](./aws/eks-helm/metrics-server/)
* Add variables for eks api endpoint access control [(./aws/eks-cluster/)](./aws/eks-cluster/)
* Add Terraform module for GitHub Actions self-hosted
  runner [(./aws/github-self-hosted-runners/)](./aws/github-self-hosted-runners/)
* Add new variables for Datadog module to enable/disable some flags [(./aws/eks-helm/datadog/)](./aws/eks-helm/datadog/)
* Add Terraform module for Keda [(./aws/eks-helm/keda/)](./aws/eks-helm/keda/)

## [0.1.58]() (2025-01-16)

### Features

* AWS Security Group: [(./aws/security-group/)](./aws/security-group/)
    * Add variable to custom ipv6_cidr_blocks of the default security group `allow_all_within_vpc`.

## [0.1.57]() (2025-01-15)

### Features

* AWS ECR [(./aws/ecr/)](./aws/ecr/)
    * Add variables `custom_ecr_scanning`, `scan_type`, `scan_frequency` to configure ecr scanning.

### Bug Fixes

* AWS S3 [(./aws/s3/)](./aws/s3/)
    * Correct access-log-policy resource (use bucket arn instead of id)

## [0.1.56]() (2025-01-15)

### Features

* AWS Postgres [(./aws/postgres/)](aws/rds/)
    * Add optional variable `snapshot_identifier` to specify whether or not to create database instance from a snapshot.

* AWS S3 [(./aws/s3/)](./aws/s3/)
    * Add a submodule `access-log-policy` to configure bucket policy to allow AWS services to write access logs from
      other services/buckets.

### Bug Fixes

* GPC ServiceConfig [(./gcp/service-config/)](./gcp/service-config/)
    * Fixed a bug where the variable `project_id` is redundant and vulnerable.

## [0.1.55]() (2025-01-14)

### Features

* AWS S3: [(./aws/s3)](./aws/s3)
    * Add variable `enabled_access_logging` and `access_log_target_bucket_id` to optionally configure access logging for
      the bucket.

* AWS EKS-Cluster [(./aws/eks-cluster/)](./aws/eks-cluster/)
    * Add variables `addons_vpc_cni_version`, `addons_kube_proxy_version`, `addons_coredns_version` to specify the
      version of addons.

## [0.1.54]() (2025-01-13)

### Bug Fixes

* AWS Elasticache: [(./aws/elasticache)](./aws/elasticache)
    * Fix `auth_token` is enabled if `transit_encryption_enabled` is true

## [0.1.53]() (2025-01-13)

### Features

* AWS EKS Helm AWS Load Balancer
  Controller: [(./aws/eks-helm/aws-load-balancer-controller)](./aws/eks-helm/aws-load-balancer-controller)
    * Change `region` variable as optional, using `data aws_region` if it is null

### Bug Fixes

* AWS SES: [(./aws/ses)](./aws/ses)
    * Handle data aws route53 zone, support when publishing the MX and DKIM records

## [0.1.52]() (2025-01-13)

### Features

* AWS password policy: [(./aws/password-policy)](./aws/password-policy/)
    * Configures an IAM account password policy in AWS
    * Enforcing security requirements such as minimum password length, required character types, and user password
      management capabilities.
* AWS MWAA: [(./aws/mwaa)](./aws/mwaa)
    * Set MWAA task log level to INFO by default.

## [0.1.51]() (2025-01-12)

### Features

* AWS OpenVPN: [(./aws/openvpn)](./aws/openvpn/)
    * Add optional existing public key value `ec2_public_key` and custom key name `key_name`.
    * Add security group to allow ssh access to vpn `default_ssh_vpn`.
    * Remove resource tag.

## [0.1.50]() (2025-01-10)

### Features

* AWS Vanta: [(./aws/vanta)](./aws/vanta/)
    * Make vanta External Scanner ID customizable via `vanta_scanner_external_id`

## [0.1.49]() (2025-01-10)

### Features

* AWS Vanta: [(./aws/vanta)](./aws/vanta/)
    * Add IAM role and IAM policy for Vanta Auditor
* AWS Neo4j: [(./aws/eks-helm/neo4j)](./aws/eks-helm/neo4j)
    * Set Neo4j auth secret and update ingress HTTP port

## [0.1.48]() (2025-01-09)

### Features

* AWS Opensearch: [(./aws/opensearch)](./aws/opensearch/)
    * Add option to create service link role via variable `create_linked_role`

## [0.1.47]() (2025-01-09)

### Features

* AWS static-website: Add `ordered_cache_behaviors` to custom
  `aws_cloudfront_distribution.ordered_cache_behavior`. [(./aws/static-website)](./aws/static-website)

## [0.1.46]() (2025-01-09)

### Features

* AWS SES: [(./aws/ses)](./aws/ses)
    * Add variable enabled_ses_identity_policy to make ses_identity_policy optional

## [0.1.45]() (2025-01-09)

### Features

* AWS SQS: [(./aws/sqs)](./aws/sqs)
    * Change `max_receive_count` type to number.
    * Separate `aws_sqs_queue.queue.redrive_policy` to `aws_sqs_queue_redrive_policy.this`.
    * Add attribute `redrive_allow_policy` to `aws_sqs_queue.dlq`.

## [0.1.44]() (2025-01-09)

### Features

* AWS SNS: Init module. [(./aws/sns)](./aws/sns)

## [0.1.43]() (2025-01-09)

### Features

* AWS elasticache: Add output `elasticache_replication_group_configuration_endpoint_address` and variable
  `transit_encryption_enabled`. [(./aws/elasticache)](./aws/elasticache)

## [0.1.42]() (2025-01-09)

### Features

* AWS
  Eks-Helm/ALB-Controller [(./aws/eks-helm/aws-load-balancer-controller/)](./aws/eks-helm/aws-load-balancer-controller/)
    * Add new policy documents and auto map associated policy based on chart_version.

## [0.1.41]() (2025-01-09)

### Features

* AWS static-website: Add `bucket_prefix`, `s3_custom_readonly_policy_name`, `s3_custom_read_write_policy_name`,
  `s3_readonly_policy_description`, `s3_read_write_policy_description` to avoid resource
  recreation. [(./aws/static-website)](./aws/static-website)

## [0.1.40]() (2025-01-08)

### Features

* AWS MWAA: [(./aws/mwaa)](./aws/mwaa)
    * Add AWS MWAA Terraform module

### Bug Fixes

* AWS OIDC Provider: [(./aws/oidc/provider)](./aws/oidc/provider)
    * Remove create `var.create_provider` from `tls_certificate` to prevent bugs.

## [0.1.39]() (2025-01-08)

### Features

* AWS SES:  [(./aws/ses)](./aws/ses)
    * Add DKIM records and MX records options.

### Bug Fixes

* AWS OIDC Provider: [(./aws/oidc/provider)](./aws/oidc/provider)
    * Update `var.create_provider` for `aws_iam_openid_connect_provider` to prevent bugs from not found

## [0.1.38]() (2025-01-07)

### Features

* Datadog aws-monitor: [(./datadog/aws-monitor)](./datadog/aws-monitor/)
    * Update `renotify_occurrences` for each default services
* Datadog monitors: [(./datadog/monitors)](./datadog/monitors/)
    * Add monitor_threshold `warning` and `warning_recovery`.
* AWS Neo4j module: [(./aws/eks-helm/neo4j)](./aws/eks-helm/neo4j)
    * Add Neo4j helm deployment module

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
* AWS S3: Add variables to overwrite policy name: `custom_readonly_policy_name`,
  `custom_read_write_policy_name` [(./aws/s3)](./aws/s3/)

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
    * Updated the logic to set from_port and to_port to -1 when the IP protocol is "-1", ensuring compatibility for
      security group rules with all protocols.

## [0.1.32]() (2024-12-31)

### Bug fixes

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

### Bug fixes

* AWS OpenVPN: [(./aws/openvpn/)](./aws/openvpn/)
    * Add missing a new line in the init script template

## [0.1.30]() (2024-12-30)

### Features

* AWS OpenVPN: [(./aws/openvpn/)](./aws/openvpn/)
    * Add a flag to determine whenever to recreate OpenVPN instance when there is update in some variables:
      `replace_instance_on_update`.
* AWS Security Group: [(./aws/security-group/)](./aws/security-group/)
    * Update Security Group Resources to Support Dynamic Ingress and Egress Rule Management
* Qdrant: [(./qdrant)](./qdrant)
    * Initial commit with all the code

## [0.1.29]() (2024-12-30)

### Features

* AWS VPC: Add private database subnet groups [(./aws/vpc)](./aws/vpc/)
* AWS VPC Endpoints: * Add support for EKS VPC endpoint configuration [(./aws/vpc-endpoints)](./aws/vpc-endpoints/)
* AWS Security Group: Add variable `custom_sg_allow_all_within_vpc_egress_ipv6_cidr_blocks` to avoid update sg during
  migration [(./aws/security-group)](./aws/security-group/)

## [0.1.28]() (2024-12-27)

### Features

* AWS Static Website: [(./aws/static-website)](./aws/static-website/)
    * Add a flag to enable www domain: `use_www_domain`
    * Add `cloudfront_distribution_aliases` variable to custom distribution aliases
    * Add `existing_s3_bucket_name` variable to specify the name of custom s3 bucket to use
* AWS OpenVPN: [(./aws/openvpn)](./aws/openvpn/)
    * Allow using this module to use various available OAuth2 provider by adding variables: `oauth2_provider`,
      `oauth2_issuer`
    * Allow validate group and role of the authorized identity via `oauth2_validate_groups` and `oauth2_validate_roles`
    * Make management ssh key optional `create_management_key_pair`
    * And add some variables for migrations: `custom_cert_dns_names`, `create_egress_vpn_rule`,
      `init_script_callback_comment`
* AWS SQS: [(./aws/sqs)](./aws/sqs/)
    * Make read/write policy's name customizable via variables `read_policy_name` and `write_policy_name`.

## [0.1.27]() (2024-12-26)

### Features

* AWS S3: [(./aws/s3)](./aws/s3)
    * Add variables to avoid forced resource replacements during rollout: `read_write_policy_description`,
      `read_write_policy_name_prefix`, `readonly_policy_description`, `readonly_policy_name_prefix`,
      `public_policy_description`, and `public_policy_name_prefix`.
* AWS Security Groups: Add variable `custom_sg_allow_all_within_vpc_egress_ipv6_cidr_blocks` to avoid update sg during
  migration [(./aws/security-group)](./aws/security-group)

## [0.1.26]() (2024-12-26)

### Features

* AWS EKS Service: Add output `service_hostnames` to generates a map of service hostnames by iterating over the Route 53
  records and extracting their fully qualified domain names (FQDNs) [(./aws/eks-service)](./aws/eks-service)

## [0.1.25]() (2024-12-26)

### Features

* AWS Security Group: Add variables: custom_sg_allow_all_description and custom_sg_allow_all_within_all_description to
  avoid forces replacement during migration. [(./aws/security-group)](./aws/security-group)

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

* AWS Security Group: Introduce functionality to create default security groups with configurable CIDR blocks and VPC
  ID.
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
* AWS Postgres: Add `var.publicly_accessible` to allow external machine connect to rds if
  `true` [(./aws/postgres)](./aws/rds)

### Bug fixes

* AWS Postgres: Correct conditions to create security group `aws_security_group.this` when variable
  `vpc_security_group_ids` is null [(./aws/postgres)](./aws/rds)

## [0.1.21]() (2024-12-24)

### Features

* AWS EKS-Helm Metrics Server: Init module. [(./aws/eks-helm/metrics-server)](./aws/eks-helm/metrics-server)
* AWS EKS-RBAC: Init module. [(./aws/eks-rbac)](./aws/eks-rbac)
* AWS SES: Rename `use_route53` to `verify_domain` and add prefix `_amazonses.` to route53 record to validate SES
  domain. [(./aws/ses)](./aws/ses)
* AWS OIDC provider: refactor and generalized [(./aws/github-oidc/modules/provider)]() to dedicated module
  at [(./aws/oidc/provider)](./aws/oidc/provider).
* AWS Jenkins OIDC: Init jenkins-oidc module. [(aws/oidc/jenkins-oidc)](./aws/oidc/jenkins-oidc)
* AWS GitHub OIDC: [(aws/oidc/github-oidc)](./aws/oidc/github-oidc)
    * Add provider `tls` version constraints.
    * Replace `var.aws_account_id` with `data.aws_caller_identity` to use runtime AWS identity.
    * Add variables: `additional_thumbprints`, `client_id_list`, `url`, `create_provider`.
    * Add outputs: `provider_arn`, `provider_url`, `github_tf_ops_role_arn`.

## [0.1.20]() (2024-12-24)

### Features

* AWS eks-helm/aws-load-balancer-controller: init
  module [(./aws/eks-helm/aws-load-balancer-controller)](./aws/eks-helm/aws-load-balancer-controller/)
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
* AWS static-website: Update `aws_cloudfront_distribution.aliases`. Add variable `domain_name`,
  `enabled_read_write_policy`, `enabled_read_only_policy`. [(./aws/static-website)](./aws/static-website).

## [0.1.16]() (2024-12-20)

### Features

* AWS Cloudwatch Alarm: Add support for specifying target group in
  alarms [(./aws/cloudwatch/alarm)](./aws/cloudwatch/alarm).

### Fix Bugs

* AWS KMS: Add policy `kms:PutKeyPolicy` to fix cannot apply because of error KMS: PutKeyPolicy [(./aws/kms)](./aws/kms)

## [0.1.15]() (2024-12-19)

### Features

* Add AWS Cloud Trail module [(./aws/cloudtrail)](./aws/cloudtrail).
* AWS Postgres: Update security group to use vpc existing security groups and allow user to overwrite rds parameter
  group name.
* AWS KMS: Change from `aws_iam_policy.this[*].arn` to `values(aws_iam_policy.this)[*].arn` in order to fix the null
  list output.
* AWS S3: Add variable `acl` and resource `aws_s3_bucket_acl`.

## [0.1.14]() (2024-12-18)

### Features

* AWS Postgre: Add `var.db_identifier` and update `identifier` naming logic from modules `main_db_instance` and
  `replica_db_instance`. Add `var.copy_tags_to_snapshot`. [(./aws/postgres)](./aws/rds)
* AWS VPC: Add variables: `create_custom_subnets`, `custom_public_subnets`, `custom_private_subnets` and update subnet
  creation logics. Correct `aws_security_group.allow_all_within_vpc` ingress rule `cidr_blocks`. Remove `environment`
  from resource tags.[(./aws/vpc)](./aws/vpc)
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
