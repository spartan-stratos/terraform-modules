# Helm/Datadog

This module installs and configures the Datadog Agent on a Kubernetes cluster via Helm chart.

## Usage

### Install Datadog Agent

```hcl
module "helm_datadog" {
  source  = "github.com/spartan-stratos/terraform-modules//helm-datadog?ref=v1.0.0"

  environment       = "dev"
  datadog_api_key   = "your-datadog-api-key"
  datadog_app_key   = "your-datadog-app-key"
  datadog_image_tag = "7"
  cloud_provider    = "gke-autopilot"
}
```

## Examples

- [Example](./example/complete/)

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                      | Version   |
|---------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8  |
| <a name="requirement_helm"></a> [helm](#requirement\_helm)                | >= 2.16.1 |

## Providers

| Name                                                    | Version   |
|---------------------------------------------------------|-----------|
| <a name="provider_helm"></a> [helm](#provider\_helm)    | >= 2.16.1 |

## Modules

No modules.

## Resources

| Name                                                                                                                         | Type     |
|------------------------------------------------------------------------------------------------------------------------------|----------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release)                   | resource |

## Inputs

| Name                                                                                                                                   | Description                                                                                                                                                                                 | Type           | Default                                                                              | Required |
|----------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|--------------------------------------------------------------------------------------|:--------:|
| <a name="input_cloud_provider"></a> [cloud\_provider](#input\_cloud\_provider)                                                         | Cloud provider platform for Datadog Agent deployment. One of: gke-autopilot, gke-cos, eks, aks.                                                                                            | `string`       | n/a                                                                                  |   yes    |
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key)                                                    | The datadog api key                                                                                                                                                                         | `string`       | n/a                                                                                  |   yes    |
| <a name="input_datadog_app_key"></a> [datadog\_app\_key](#input\_datadog\_app\_key)                                                    | The datadog app key                                                                                                                                                                         | `string`       | n/a                                                                                  |   yes    |
| <a name="input_datadog_image_tag"></a> [datadog\_image\_tag](#input\_datadog\_image\_tag)                                              | The Datadog Agent and Cluster Agent image tag.                                                                                                                                              | `string`       | n/a                                                                                  |   yes    |
| <a name="input_environment"></a> [environment](#input\_environment)                                                                    | Environment where the resources will be created.                                                                                                                                            | `string`       | n/a                                                                                  |   yes    |
| <a name="input_container_exclude"></a> [container\_exclude](#input\_container\_exclude)                                                | Space-separated list of container filters that Datadog will NOT collect logs/metrics from. Matched containers are silenced. Default excludes all namespaces; use container_include to allow specific ones back in. | `string` | `"kube_namespace:.*"` |    no    |
| <a name="input_container_include"></a> [container\_include](#input\_container\_include)                                                | Space-separated list of container filters that Datadog WILL collect logs/metrics from. Takes precedence over container_exclude, so only namespaces/containers matching these patterns are monitored. | `string` | `"kube_namespace:^service-.* kube_namespace:^datadog$ name:^controller$"` |    no    |
| <a name="input_deployment_cpu"></a> [deployment\_cpu](#input\_deployment\_cpu)                                                         | The Datadog deployment cpu                                                                                                                                                                  | `string`       | `"250m"`                                                                             |    no    |
| <a name="input_deployment_memory"></a> [deployment\_memory](#input\_deployment\_memory)                                                | The Datadog deployment memory                                                                                                                                                               | `string`       | `"512Mi"`                                                                            |    no    |
| <a name="input_deployment_replicas"></a> [deployment\_replicas](#input\_deployment\_replicas)                                          | The Datadog deployment replicas                                                                                                                                                             | `number`       | `1`                                                                                  |    no    |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name)                                              | The Helm release of the services.                                                                                                                                                           | `string`       | `"datadog"`                                                                          |    no    |
| <a name="input_http_check_urls"></a> [http\_check\_urls](#input\_http\_check\_urls)                                                    | The list of urls for http check                                                                                                                                                             | `list(string)` | `[]`                                                                                 |    no    |
| <a name="input_namespace"></a> [namespace](#input\_namespace)                                                                          | The Namespace of the services.                                                                                                                                                              | `string`       | `"datadog"`                                                                          |    no    |
| <a name="input_remote_config_enabled"></a> [remote\_config\_enabled](#input\_remote\_config\_enabled)                                  | Enable Remote Config feature (see https://docs.datadoghq.com/agent/remote_config/)                                                                                                         | `bool`         | `false`                                                                              |    no    |
| <a name="input_rolling_agent_max_unavailable"></a> [rolling\_agent\_max\_unavailable](#input\_rolling\_agent\_max\_unavailable)        | Maximum number or percentage of Datadog Agent pods that can be unavailable during a rolling update.                                                                                         | `string`       | `"30%"`                                                                              |    no    |
| <a name="input_timeout"></a> [timeout](#input\_timeout)                                                                                | Default timeout of datadog                                                                                                                                                                  | `number`       | `1200`                                                                               |    no    |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
