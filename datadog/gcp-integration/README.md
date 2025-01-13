# Datadog GCP integration module

Terraform module which creates Datadog GCP integration and service account resources on GCP.

## Usage

### Create Artifact Registry

```hcl
module "datadog_gcp_integration" {
  source  = "github.com/spartan-stratos/terraform-modules//datadog/gcp-integration?ref=v0.1.22"

  datadog_account_id   = "datadog"
}
```

## Examples

- [Example](./examples/complete/)

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                      | Version  |
|---------------------------------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_datadog"></a> [datadog](#requirement\_datadog)       | >= 3.50  |
| <a name="requirement_google"></a> [google](#requirement\_google)          | >= 6.12  |

## Providers

| Name                                                          | Version |
|---------------------------------------------------------------|---------|
| <a name="provider_datadog"></a> [datadog](#provider\_datadog) | >= 3.50 |
| <a name="provider_google"></a> [google](#provider\_google)    | >= 6.12 |

## Modules

| Name                                                                                | Source                          | Version |
|-------------------------------------------------------------------------------------|---------------------------------|---------|
| <a name="module_service_account"></a> [service\_account](#module\_service\_account) | ../../../../gcp/service-account | n/a     |

## Resources

| Name                                                                                                                                                | Type     |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [datadog_integration_gcp_sts.this](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/integration_gcp_sts)               | resource |
| [google_service_account_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name                                                                                         | Description                                                                                                                                                                                                                                               | Type           | Default                                                                                                                                                                  | Required |
|----------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------:|
| <a name="input_datadog_account_id"></a> [datadog\_account\_id](#input\_datadog\_account\_id) | The datadog account name to create.                                                                                                                                                                                                                       | `string`       | n/a                                                                                                                                                                      |   yes    |
| <a name="input_datadog_roles"></a> [datadog\_roles](#input\_datadog\_roles)                  | Datadog service account should have compute.viewer, monitoring.viewer, cloudasset.viewer, and browser roles (the browser role is only required in the default project of the service account).                                                            | `list(string)` | <pre>[<br/>  "roles/compute.viewer",<br/>  "roles/container.viewer",<br/>  "roles/monitoring.viewer",<br/>  "roles/cloudasset.viewer",<br/>  "roles/browser"<br/>]</pre> |    no    |
| <a name="input_host_filters"></a> [host\_filters](#input\_host\_filters)                     | A string used to filter the hosts sent from GCP to Datadog. Only hosts matching the specified tags will be included. Tags should be in the format 'key:value' and multiple tags can be separated by commas (e.g., 'environment:production,datadog:true'). | `string`       | `"datadog:true"`                                                                                                                                                         |    no    |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
