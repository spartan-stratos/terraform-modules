# Changelog

All notable changes to this project will be documented in this file.

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
