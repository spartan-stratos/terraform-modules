# Changelog

All notable changes to this project will be documented in this file.
## [0.1.22]() (2024-12-25)
### Features
* Correct conditions to create security group `aws_security_group.this` when variable `vpc_security_group_ids` is null.
* Add `var.publicly_accessible` to allow external machine connect to rds if `true`.

## [0.1.15]() (2024-12-19)
### Features
* Add `var.custom_parameter_group_name` and `var.vpc_security_group_ids` to overwrite parameter group name and use exising security group ids.

## [0.1.14]() (2024-12-18)
### Features
* Add `var.db_identifier` and update `identifier` naming logic from modules `main_db_instance` and `replica_db_instance`.
* Add `var.copy_tags_to_snapshot`.

## [0.1.4]() (2024-12-05)
### Features
* Update terraform version constraint from `~> 1.9.8` to `>= 1.9.8` 

## [0.1.1]() (2024-11-29)
### Features
* Refactor RDS module to make it generally

## [0.1.0]() (2024-11-06)
### Features
* Initial commit with all the code

