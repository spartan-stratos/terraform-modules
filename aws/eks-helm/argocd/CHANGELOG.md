# Changelog

All notable changes to this project will be documented in this file.
## [0.3.15]() (2025-04-11)

### Features

* Add predefined group rules for projects.
* Update destinations for projects and root applications
* Update condition for adding in-cluster and rename it

## [0.3.12]() (2025-04-10)

### Features

* Add annotations for adding new roles

### Fix Bugs

* Fix Github Repository Connection
* Fix projects permission
* Update OIDC arn to OIDC url for cluster connection

### Fix Bugs

* Fix issues relating to yaml format in `tolerations`
* Change `oidc_role_arn` to `oidc_url`
* Fix indent for cluster connections

## [0.3.8]() (2025-04-04)

### Features

* Convert to `yaml` file
* Update Ingress and OIDC Connection
* Add `issuer_url` for dex config

## [0.3.6]() (2025-04-04)

### Features

* Add tolerants which will schedule argocd to managed node

## [0.3.5]() (2025-04-04)

### Fix Bugs

* Remove those attributes when creating helm argocd
```hcl
  wait             = true
  timeout          = 300
```

## [0.3.3]() (2025-04-03)

### Features

* Update provider version
* Split CRDs include `Projects` and `Applications` to a single sub-module, which will handle creating Projects and Applications.

## [0.3.2]() (2025-04-01)

### Features

* Initial commit with all the code
