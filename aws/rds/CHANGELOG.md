# Changelog

All notable changes to this project will be documented in this file.

## [0.1.79]() (2025-03-11)

### Features

* Add variable `use_secret_manager` to create Secret Manager for database password management.
* Add variable `db_subnet_group_name` for migration purpose.
* Add variable `additional_postgres_parameters` for additional parameters on PostgreSQL instance.

### Fix

* Correct `copy_tags_to_snapshot` input to submodule `db_instance`.

## [0.1.75]() (2025-03-07)

### Features

* Rename module to `rds`
* Rewrite the code to support multiple RDS engines

## [0.1.4]() (2024-12-05)

### Features

* Update terraform version constraint from `~> 1.9.8` to `>= 1.9.8`

## [0.1.1]() (2024-11-29)

### Features

* Refactor RDS module to make it generally

## [0.1.0]() (2024-11-06)

### Features

* Initial commit with all the code

