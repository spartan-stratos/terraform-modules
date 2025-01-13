# Changelog

All notable changes to this project will be documented in this file.

## [0.1.35]() (2025-01-03)

### Features

* Update provider urls (remove `registry.terraform.io`) in order for OpenTofu to map to their registry.

## [0.1.28]() (2024-12-27)

### Features

* Add `var.efs_filesystem_name` to overwrite the default efs filesystem name

## [0.1.19]() (2024-12-23)

### Features

* Add output datadog_agent_cluster_role_name to root module and remove default value of datadog_agent_cluster_role_name
  in submodule
* Change assume policy of `eks-node-cluster` from `eks.amazonaws.com` to `ec2.amazonaws.com`

## [0.1.4]() (2024-12-05)

### Features

* Update terraform version constraint from `~> 1.9.8` to `>= 1.9.8`

## [0.1.0]() (2024-11-06)

### Features

* Initial commit with all the code

