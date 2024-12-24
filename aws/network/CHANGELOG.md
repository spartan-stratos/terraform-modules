# Changelog

All notable changes to this project will be documented in this file.

## [0.1.20]() (2024-12-24)
### Features
* Reorganized the VPC and Security Group code to improve modularity and maintainability. 
* Moved security-group resources into a dedicated module and updated related examples, documentation, and outputs accordingly. 
* Adjusted paths and removed deprecated or redundant configurations to streamline resource management.

## [0.1.14]() (2024-12-18)
### Features
* Add variables: `create_custom_subnets`, `custom_public_subnets`, `custom_private_subnets` and update subnet creation logics.
* Correct `aws_security_group.allow_all_within_vpc` ingress rule `cidr_blocks`.
* Remove `environment` from resource tags.

## [0.1.4]() (2024-12-05)
### Features
* Update terraform version constraint from `~> 1.9.8` to `>= 1.9.8` 

## [0.1.0]() (2024-11-06)
### Features
* Initial commit with all the code
