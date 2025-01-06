# Changelog

All notable changes to this project will be documented in this file.

## [0.1.37]() (2025-01-06)
### Features
* Add `override.tofu` to override Terraform version constrain with OpenTofu

## [0.1.28]() (2024-12-27)
### Features
* Add a flag to enable www domain: `use_www_domain`
* Add `cloudfront_distribution_aliases` variable to custom distribution aliases
* Add `existing_s3_bucket_name` variable to specify the name of custom s3 bucket to use

## [0.1.17]() (2024-12-23)
### Features
* Update aws_cloudfront_distribution.aliases.
* Add variables `domain_name` to root module and sub-module `cloudfront`.
* Add variables `enabled_read_write_policy`, `enabled_read_only_policy` to root module and to s3 module.

## [0.1.4]() (2024-12-05)
### Features
* Update terraform version constraint from `~> 1.9.8` to `>= 1.9.8` 

## [0.1.2]() (2024-12-04)
### Features
* Use HTTP to HTTPS policy to all behaviors

## [0.1.0]() (2024-11-06)
### Features
* Initial commit with all the code
