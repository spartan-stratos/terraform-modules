# Changelog

All notable changes to this project will be documented in this file.
## [0.5.1]() (2024-01-05)

### Features

* Update restart datadog monitor being triggered by using diff function, which will check the increase restarting, for example if the pod restarted, the query template will count to 1, after that it will be 0 if there is no more increase in restart metrics.


## [0.1.36]() (2024-01-05)

### Features

* Initial commit with all the code
