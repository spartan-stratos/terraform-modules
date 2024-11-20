# Spartan Terraform Modules

## How to use modules

Follow the syntax:

```terraform
# For modules in subdirectories as PATH, and for tag as REF.
# Take note of the double slash // before the path.
source = "git@github.com:github.com/spartan-stratos/terraform-modules//<PATH>?ref=<REF>"

# Or, for short
source = "github.com/spartan-stratos/terraform-modules//<PATH>?ref=<REF>"

# And if you want to use latest version (not recommended)
source = "github.com/spartan-stratos/terraform-modules//<PATH>"
```

For example:

```terraform
module "acm" {
  source = "github.com/spartan-stratos/terraform-modules//aws/acm?ref=v0.1.0"

  zone_id     = "example"
  domain_name = "example.com"
  subject_alternative_names = [
    "*.example.com"
  ]

  wait_for_validation = false

  tags = {
    Name = "example.com"
  }
}
```

After adding to your .tf file, run `terraform init --upgrade` or `terraform get` to download the module(s) from github repository.

---
## Table of contents

Spartan Terraform Conventions and Standards:

1. [Module structure](#module-structure)
2. [Naming convention](#naming-convention)
3. [Variables](#variables)
4. [Outputs](#outputs)
5. [Data sources](#data-sources)
6. [Limit the use of custom scripts](#limit-the-use-of-custom-scripts)
7. [Helper scripts](#helper-scripts)
8. [Static files](#static-files)
9. [Protect stateful resources](#protect-stateful-resources)
10. [Use built-in formatting](#use-built-in-formatting)
11. [Limit the complexity of expressions](#limit-the-complexity-of-expressions)
12. [Use count for conditional values](#use-count-for-conditional-values)
13. [Use for_each for iterated resources](#use-for_each-for-iterated-resources)
14. [Publish modules to a registry](#publish-modules-to-a-registry)
15. [Release tagged versions](#release-tagged-versions)
16. [Don't configure providers or backends for shared modules](#dont-configure-providers-or-backends-for-shared-modules)
17. [Expose labels as a variable](#expose-labels-as-a-variable)
18. [Expose outputs for all resources](#expose-outputs-for-all-resources)
19. [Minimize the number of resources in each root module](#minimize-the-number-of-resources-in-each-root-module)
20. [README.md template](#readmemd-template)
21. [CHANGELOG.md template](#changelogmd-template)

## Release process

This section describes the release process for smooth maintenance.

1. Create and merge PR on module modifications.
2. Create and merge PR on `./CHANGELOG.md` (must follow the conventions to successfully create the release).
3. The `release` pipeline will be triggered automatically on `./CHANGELOG.md` modifications.

## **Module structure**

- Terraform modules must follow the [standard module structure](https://www.terraform.io/docs/modules/create.html):
    - `main.tf` - Input variables to accept values from the calling module.
    - `outputs.tf` - Output values to return results to the calling module, which it can then use to populate arguments elsewhere.
    - `variables.tf` - Defines input variables for the module, such as configuration settings or parameters needed by the resources in `main.tf`.
    - `version.tf` - Specifies required Terraform version and provider constraints for compatibility and dependency management.

```jsx
module/
└── examples/
    └── complete/
        └── README.md
        └── main.tf
        └── outputs.tf
        └── variables.tf
        └── versions.tf
├── CHANGELOG.md
├── README.md
├── main.tf
├── outputs.tf
├── variables.tf
├── versions.tf
```

- Start every module with a `main.tf` file, where resources are located by default.
- In every module, include a `README.md` file in Markdown format. In the `README.md` file, include basic documentation about the module.
- Place examples in an `examples/` folder, with a separate subdirectory for each example. For each example, include a detailed `README.md` file.
- Create logical groupings of resources with their own files and descriptive names, such as `network.tf`, `instances.tf`, or `loadbalancer.tf`.
    - Avoid giving every resource its own file. Group resources by their shared purpose. For example, combine `google_dns_managed_zone` and `google_dns_record_set` in `dns.tf`.
- In the module's root directory, include only Terraform (`.tf`) and repository metadata files (such as `README.md` and `CHANGELOG.md`).
- Place any additional documentation in a `docs/` subdirectory.

## Naming convention

- Name all configuration objects using underscores to delimit multiple words. This practice ensures consistency with the naming convention for resource types, data source types, and other predefined values. This convention does not apply to name [arguments](https://www.terraform.io/docs/glossary#argument).

  👍 **Recommended:**

    ```
    resource "google_compute_instance""web_server" {
      name = "web-server"
    }
    ```

  👎 **Not recommended:**

    ```
    resource "google_compute_instance""web-server" {
      name = "web-server"
    }
    ```

- To simplify references to a resource that is the only one of its type (for example, a single load balancer for an entire module), name the resource `main`.
    - It takes extra mental work to remember `some_resource.my_special_resource.id` versus `some_resource.main.id`.
- To differentiate resources of the same type from each other (for example, `primary` and `secondary`), provide meaningful resource names.
- Make resource names singular.
- In the resource name, don't repeat the resource type. For example:

  👍 **Recommended:**

    ```
    resource "google_compute_global_address" "main" { ... }
    ```

  👎 **Not recommended:**

    ```
    resource "google_compute_global_address" "main_global_address" { … }
    ```


## Variables

- Declare all variables in `variables.tf`.
- Give variables descriptive names that are relevant to their usage or purpose:
    - Inputs, local variables, and outputs representing numeric values—such as disk sizes or RAM size—*must* be named with units (such as `ram_size_gb`). Google Cloud APIs don't have standard units, so naming variables with units makes the expected input unit clear for configuration maintainers.
    - For units of storage, use binary unit prefixes (powers of 1024)—`kibi`, `mebi`, `gibi`. For all other units of measurement, use decimal unit prefixes (powers of 1000)—`kilo`, `mega`, `giga`. This usage matches the usage within Google Cloud.
    - To simplify conditional logic, give boolean variables positive names—for example, `enable_external_access`.
- Variables must have descriptions. Descriptions are automatically included in a published module's auto-generated documentation. Descriptions add additional context for new developers that descriptive names cannot provide.
- Give variables defined types.
- When appropriate, provide default values:
    - For variables that have environment-independent values (such as disk size), provide default values.
    - For variables that have environment-specific values (such as `project_id`), don't provide default values. This way, the calling module must provide meaningful values.
- Use empty defaults for variables (like empty strings or lists) only when leaving the variable empty is a valid preference that the underlying APIs don't reject.
- Be judicious in your use of variables. Only parameterize values that must vary for each instance or environment. When deciding whether to expose a variable, ensure that you have a concrete use case for changing that variable. If there's only a small chance that a variable might be needed, don't expose it.
    - Adding a variable with a default value is backwards-compatible.
    - Removing a variable is backwards-incompatible.
    - In cases where a literal is reused in multiple places, you can use a [local value](https://www.terraform.io/docs/configuration/locals.html) without exposing it as a variable.

## Outputs

- Organize all outputs in an `outputs.tf` file.
- Provide meaningful descriptions for all outputs.
- Document output descriptions in the `README.md` file. Auto-generate descriptions on commit with tools like [terraform-docs](https://github.com/terraform-docs/terraform-docs).
- Output all useful values that root modules might need to refer to or share. Especially for open source or heavily used modules, expose all outputs that have potential for consumption.
- Don't pass outputs directly through input variables, because doing so prevents them from being properly added to the dependency graph. To ensure that [implicit dependencies](https://learn.hashicorp.com/terraform/getting-started/dependencies.html) are created, make sure that outputs reference attributes from resources. Instead of referencing an input variable for an instance directly, pass the attribute through as shown here:

  👍 **Recommended:**

    ```
    output "name" {
      description = "Name of instance"
      value       = google_compute_instance.main.name
    }
    ```

  👎 **Not recommended:**

    ```
    output "name" {
      description = "Name of instance"
      value       = var.name
    }
    ```


## Data sources

- Put [data sources](https://www.terraform.io/docs/configuration/data-sources.html) next to the resources that reference them. For example, if you are fetching an image to be used in launching an instance, place it alongside the instance instead of collecting data resources in their own file.
- If the number of data sources becomes large, consider moving them to a dedicated `data.tf` file.
- To fetch data relative to the current environment, use variable or resource [interpolation](https://www.terraform.io/language/expressions/strings#interpolation).

## Limit the use of custom scripts

- Use scripts only when necessary. The state of resources created through scripts is not accounted for or managed by Terraform.
    - Avoid custom scripts, if possible. Use them only when Terraform resources don't support the desired behavior.
    - Any custom scripts used must have a clearly documented reason for existing and ideally a deprecation plan.
- Terraform can call custom scripts through provisioners, including the local-exec provisioner.
- Put custom scripts called by Terraform in a `scripts/` directory.

## Helper scripts

- Organize helper scripts that aren't called by Terraform in a `helpers/` directory.
- Document helper scripts in the `README.md` file with explanations and example invocations.
- If helper scripts accept arguments, provide argument-checking and `-help` output.

## Static files

- Static files that Terraform references but doesn't execute (such as startup scripts loaded onto Compute Engine instances) must be organized into a `files/` directory.
- Place lengthy HereDocs in external files, separate from their HCL. Reference them with the [`file()` function](https://www.terraform.io/language/functions/file).
- For files that are read in by using the Terraform [`templatefile` function](https://www.terraform.io/docs/configuration/functions/templatefile.html), use the file extension `.tftpl`.
    - Templates must be placed in a `templates/` directory.

## Protect stateful resources

For stateful resources, such as databases, ensure that [deletion protection](https://www.terraform.io/language/meta-arguments/lifecycle) is enabled. For example:

```
resource "google_sql_database_instance" "main" {
  name = "primary-instance"
  settings {
    tier = "D0"
  }

  lifecycle {
    prevent_destroy = true
  }
}
```

## Use built-in formatting

All Terraform files must conform to the standards of `terraform fmt`.

## Limit the complexity of expressions

- Limit the complexity of any individual interpolated expressions. If many functions are needed in a single expression, consider splitting it out into multiple expressions by using [local values](https://www.terraform.io/docs/configuration/locals.html).
- Never have more than one ternary operation in a single line. Instead, use multiple local values to build up the logic.

## Use `count` for conditional values

To instantiate a resource conditionally, use the [`count`](https://www.terraform.io/language/meta-arguments/count) meta-argument. For example:

```
variable "readers" {
  description = "..."
  type        = list
  default     = []
}

resource "resource_type" "reference_name" {
  // Do not create this resource if the list of readers is empty.
  count = length(var.readers) == 0 ? 0 : 1
  ...
}
```

Be sparing when using user-specified variables to set the `count` variable for resources. If a resource attribute is provided for such a variable (like `project_id`) and that resource does not yet exist, Terraform can't generate a plan. Instead, Terraform reports the error [`value of count cannot be computed`](https://github.com/hashicorp/terraform/issues/17421). In such cases, use a separate `enable_x` variable to compute the conditional logic.

## Use `for_each` for iterated resources

If you want to create multiple copies of a resource based on an input resource, use the [`for_each`](https://www.terraform.io/language/meta-arguments/for_each) meta-argument.

## Publish modules to a registry

- **Reusable modules**: Publish reusable modules to a [module registry](https://www.terraform.io/internals/module-registry-protocol).
- **Open source modules**: Publish open source modules to the [Terraform Registry](https://registry.terraform.io/).
- **Private modules**: Publish private modules to a [private registry](https://www.terraform.io/cloud-docs/registry).

## Release tagged versions

Sometimes modules require breaking changes and you need to communicate the effects to users so that they can pin their configurations to a specific version.

Make sure that shared modules follow [SemVer v2.0.0](https://semver.org/spec/v2.0.0.html) when new versions are tagged or released.

When referencing a module, use a [version constraint](https://www.terraform.io/language/expressions/version-constraints) to pin to the *major* version. For example:

```
module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 20.0"
}
```

## Don't configure providers or backends for shared modules

Shared modules [must not configure providers or backends](https://developer.hashicorp.com/terraform/language/providers/configuration#provider-configuration-1). Instead, configure providers and backends in root modules.

For shared modules, define the minimum required provider versions in a [`required_providers`](https://www.terraform.io/language/modules/develop/providers#provider-version-constraints-in-modules) block, as follows:

```
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
}
```

Unless proven otherwise, assume that new provider versions will work.

## Expose labels as a variable

Allow flexibility in the labeling of resources through the module's interface. Consider providing a `labels` variable with a default value of an empty map, as follows:

```
variable "labels" {
  description = "A map of labels to apply to contained resources."
  default     = {}
  type        = "map"
}
```

## Expose outputs for all resources

Variables and outputs let you infer dependencies between modules and resources. Without any outputs, users cannot properly order your module in relation to their Terraform configurations.

For every resource defined in a shared module, include at least one output that references the resource.

## Minimize the number of resources in each root module

It is important to keep a single root configuration from growing too large, with too many resources stored in the same directory and state. *All* resources in a particular root configuration are refreshed every time Terraform is run. This can cause slow execution if too many resources are included in a single state. A general rule: Don't include more than 100 resources (and ideally only a few dozen) in a single state.

## [README.md](http://README.md) template

```markdown
# AWS ABC Terraform module

Terraform module which creates ABC resources on AWS.

## Usage

## Examples

## Requirements
| Name | Version |
|------|---------|

## Resources

## Inputs

## Outputs
```

## [CHANGELOG.md](http://CHANGELOG.md) template

```markdown
# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0](https://github.com/repo/compare/v0.0.1...v1.0.0) (2024-01-01)

### ⚠ BREAKING CHANGES

* Bump version (#1)

### Features

* Add abc ([#1](https://pr-link) ([2517eb9](https://commit-link))

### Bug Fixes

* Fix abc ([#1](https://pr-link) ([2517eb9](https://commit-link))
```

## References

- https://www.terraform-best-practices.com/
- https://developer.hashicorp.com/terraform/cloud-docs/recommended-practices
- https://cloud.google.com/docs/terraform/best-practices/general-style-structure
- https://cloud.google.com/docs/terraform/best-practices/reusable-modules
- https://cloud.google.com/docs/terraform/best-practices/root-modules
