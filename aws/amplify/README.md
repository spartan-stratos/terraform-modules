# AWS Amplify app Terraform module
Terraform module to provision AWS Amplify apps, backend environments, branches, domain associations.

Depends on the app types (SSG or SSR), you will have to manually change the buildspec as this [guideline](https://docs.aws.amazon.com/amplify/latest/userguide/deploy-nextjs-app.html)

## Usage
### Next.js app
```hcl
module "website" {
  source  = "terraform-c0x12c-modules/amplify/aws"
  version = "~> 1.0"

  dns_zone         = "example.com"
  environment      = "dev"
  repository       = "https://github.com/example-org/example-repo"
  application_root = "./"
  build_variables = {
    NEXT_PUBLIC_DOMAIN = "https://test.example.com"
    NEXT_PUBLIC_ENV    = "dev"
  }
  github_token             = "example"
  deploy_branch_name       = "master"
  sub_domain               = "test"
  name                     = "example"
  install_command          = "yarn install"
  build_command            = "yarn build"
  base_artifacts_directory = ".next"
}

```

## Examples
- [Example](./examples/nextjs-app/).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.75 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.75 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_amplify_app.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_app) | resource |
| [aws_amplify_backend_environment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_backend_environment) | resource |
| [aws_amplify_branch.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_branch) | resource |
| [aws_amplify_domain_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/amplify_domain_association) | resource |
| [aws_iam_role.amplify_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.amplify_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_policy_document.amplify_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_root"></a> [application\_root](#input\_application\_root) | The root directory for building application | `string` | n/a | yes |
| <a name="input_base_artifacts_directory"></a> [base\_artifacts\_directory](#input\_base\_artifacts\_directory) | Base directory that stores build artifacts | `string` | `".next"` | no |
| <a name="input_build_command"></a> [build\_command](#input\_build\_command) | The build command to execute JS scripts | `string` | `"yarn build"` | no |
| <a name="input_build_variables"></a> [build\_variables](#input\_build\_variables) | Map of environment variables for building app | `map(string)` | n/a | yes |
| <a name="input_custom_redirect_rules"></a> [custom\_redirect\_rules](#input\_custom\_redirect\_rules) | Custom redirect rules for redirecting requests to Amplify app | <pre>list(object({<br/>    source = string<br/>    status = string<br/>    target = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "source": "/<*>",<br/>    "status": "404",<br/>    "target": "/index.html"<br/>  }<br/>]</pre> | no |
| <a name="input_deploy_branch_name"></a> [deploy\_branch\_name](#input\_deploy\_branch\_name) | The branch name to deploy the source code | `string` | n/a | yes |
| <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone) | DNS zone for creating domain | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment for the Amplify app | `string` | n/a | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | Github access token for authorizing with Github | `string` | n/a | yes |
| <a name="input_install_command"></a> [install\_command](#input\_install\_command) | The install command to install packages | `string` | `"yarn install"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name for the Amplify app | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | Source repository for Amplify app | `string` | n/a | yes |
| <a name="input_sub_domain"></a> [sub\_domain](#input\_sub\_domain) | Subdomain for the Amplify app | `string` | n/a | yes |
| <a name="input_web_platform"></a> [web\_platform](#input\_web\_platform) | Amplify App platform for building web app | `string` | `"WEB"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amplify App ARN |
| <a name="output_backend_environment_arn"></a> [backend\_environment\_arn](#output\_backend\_environment\_arn) | Created backend environment arn |
| <a name="output_backend_environment_name"></a> [backend\_environment\_name](#output\_backend\_environment\_name) | Created backend environment name |
| <a name="output_name"></a> [name](#output\_name) | Amplify App name |
| <a name="output_role_policy_name"></a> [role\_policy\_name](#output\_role\_policy\_name) | Created role policy name |
<!-- END_TF_DOCS -->