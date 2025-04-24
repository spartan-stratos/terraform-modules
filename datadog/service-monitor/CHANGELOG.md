# Changelog

All notable changes to this project will be documented in this file.
## [0.5.1]() (2024-04-24)

### Breaking changes

* Modify the Datadog restart monitor to use the diff function, which captures only new restart events. When a pod restarts, the query returns a value of 1, and it falls back to 0 if no further restarts occur.

## [0.1.36]() (2024-01-05)

### Features

* Initial commit with all the code
