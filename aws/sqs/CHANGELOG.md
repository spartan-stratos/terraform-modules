# Changelog

All notable changes to this project will be documented in this file.
## [0.1.28]() (2024-12-26)
### Features
* Add customizable prefix for read/write policy name via variables `read_policy_name_prefix` and `write_policy_name_prefix`.

## [0.1.20]() (2024-12-24)
### Features
* Refactor components.
* Update policies Send Receive resources principal to created queue only.
* Update policy Receive with 2 additional permissions: "sqs:DeleteMessage", "sqs:GetQueueAttributes".
* Remove redundant policy in aws_sqs_queue.queue.

## [0.1.4]() (2024-12-05)
### Features
* Update terraform version constraint from `~> 1.9.8` to `>= 1.9.8` 

## [0.1.0]() (2024-11-06)
### Features
* Initial commit with all the code

