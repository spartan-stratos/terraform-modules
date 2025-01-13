# Google workspace group Terraform module

This Terraform module create and manage a group of members within the Google workspace group created.

## Usage

### Create Google group workspace

```hcl
module "google_workspace_group" {
  source = "github.com/spartan-stratos/terraform-modules//gcp/google-workspace/modules/group?ref=v0.1.5"

  identifier  = "example_project_developers"
  domain      = "example.com"
  name        = "Example Project Developers"
  description = "Team Example Project Developers"
  members = [
    "member_1",
    "member_2"
  ]
}
```

## Examples

- [Example](./examples/complete/)

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                                        | Version   |
|---------------------------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform)                   | \>= 1.9.8 |
| <a name="requirement_googleworkspace"></a> [googleworkspace](#requirement\_googleworkspace) | \>= 0.7.0 |

## Providers

| Name                                                                                  | Version   |
|---------------------------------------------------------------------------------------|-----------|
| <a name="provider_googleworkspace"></a> [googleworkspace](#provider\_googleworkspace) | \>= 0.7.0 |

## Modules

| Name                                                                          | Source                                                                           | Version |
|-------------------------------------------------------------------------------|----------------------------------------------------------------------------------|---------|
| <a name="module_gke_autopilot"></a> [gke\_autopilot](#module\_gke\_autopilot) | github.com/spartan-stratos/terraform-modules//gcp/google-workspace/modules/group | v0.1.5  |

## Resources

| Name                                                                                                                                      | Type     |
|-------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [googleworkspace_group.this](https://registry.terraform.io/providers/hashicorp/googleworkspace/latest/docs/resources/group)               | resource |
| [googleworkspace_group_member.this](https://registry.terraform.io/providers/hashicorp/googleworkspace/latest/docs/resources/group_member) | resource |

## Inputs

| Name                                                                | Description                                                                                                                                                                                    | Type           | Default | Required |
|---------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The description for the Google Workspace group.                                                                                                                                                | `string`       | `null`  |    no    |
| <a name="input_domain"></a> [domain](#input\_domain)                | The domain associated with the Google Workspace group.                                                                                                                                         | `string`       | n/a     |   yes    |
| <a name="input_identifier"></a> [identifier](#input\_identifier)    | The unique identifier (such as a group name or alias) used to create the email address for the Google Workspace group. Combined with the domain, it forms the full email address of the group. | `string`       | n/a     |   yes    |
| <a name="input_members"></a> [members](#input\_members)             | A list of email address prefix (without domain) representing the members to be added to the Google Workspace group.                                                                            | `list(string)` | `[]`    |    no    |
| <a name="input_name"></a> [name](#input\_name)                      | The name of the Google Workspace group. This name will be used to identify the group in the Google Workspace Admin Console.                                                                    | `string`       | n/a     |   yes    |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
