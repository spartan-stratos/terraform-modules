# Changelog

All notable changes to this project will be documented in this file.
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
