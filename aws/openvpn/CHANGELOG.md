# Changelog

All notable changes to this project will be documented in this file.

## [0.1.51]() (2025-01-12)

### Feature

* Add optional existing public key value `ec2_public_key` and custom key name `key_name`.
* Add security group to allow ssh access to vpn `default_ssh_vpn`.
* Remove resource tag.

## [0.1.33]() (2025-01-02)

### Feature

* Add outputs for EC2 instance.
* Introduced `http_tokens` and `http_endpoint` variables to control instance metadata service settings.

## [0.1.31]() (2024-12-30)

### Fix

* Fix missing a new line in the init script cause server not configure properly.

## [0.1.30]() (2024-12-30)

### Fix

* Add a flag to determine whenever to recreate OpenVPN instance when there is update in some variables:
  `replace_instance_on_update`.

## [0.1.28]() (2024-12-26)

### Features

* Allow using this module to use various available OAuth2 provider by adding variables: `oauth2_provider`,
  `oauth2_issuer`
* Allow validate group and role of the authorized identity via `oauth2_validate_groups` and `oauth2_validate_roles`
* Make management ssh key optional `create_management_key_pair`
* And add some variables for migrations: `custom_cert_dns_names`, `create_egress_vpn_rule`,
  `init_script_callback_comment`

## [0.1.13]() (2024-12-17)

### Features

* Init and update OpenVPN module
