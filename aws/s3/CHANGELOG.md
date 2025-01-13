# Changelog

All notable changes to this project will be documented in this file.

## [0.1.36]() (2024-01-06)

### Features

* Add variables to avoid forced resource replacements during rollout: `custom_readonly_policy_name`,
  `custom_read_write_policy_name`.

## [0.1.27]() (2024-12-26)

### Features

* Add variables to avoid forced resource replacements during rollout: `read_write_policy_description`,
  `read_write_policy_name_prefix`, `readonly_policy_description`, `readonly_policy_name_prefix`,
  `public_policy_description`, and `public_policy_name_prefix`.

## [0.1.24]() (2024-12-26)

### Features

* Add attribute `expose_headers` to variable `cors_configuration`.

## [0.1.18]() (2024-12-23)

### Features

* Add output `iam_policy_s3_bucket_assets_read_write_arn`.

## [0.1.15]() (2024-12-19)

### Features

* Add variable `acl` and resource `aws_s3_bucket_acl`.

## [0.1.12]() (2024-12-17)

### Features

* Add attribute `force_destroy` for s3 bucket
* Add `read_write_policy`

## [0.1.4]() (2024-12-05)

### Features

* Update terraform version constraint from `~> 1.9.8` to `>= 1.9.8`

## [0.1.0]() (2024-11-06)

### Features

* Initial commit with all the code

