# Datadog Service Monitor module

Terraform module which creates Datadog monitors for services, supporting:

- Python

with monitors:

- HTTP check
- Pod statuses (Failed, CrashLoopBackOff, PullImageBackOff, Restarted)
- Pod resource utilization (CPU, memory)
- Service P95 latency, request hit, error hit.

## Usage
### Create Datadog service monitors
```hcl
module "service_monitor" {
  source  = "github.com/spartan-stratos/terraform-modules//datadog/service-monitor?ref=v0.1.35"

  notification_slack_channel_prefix = "proj-service-x-"
  environment                       = "dev"
  tag_slack_channel                 = false
  cluster_name                      = "proj-service-dev"
  enabled_modules                   = ["http_check", "k8s", "resource", "service"]

  service_names = {
    "service-platform" = {
      enabled_pods_monitor    = true
      enabled_cpu_monitor     = true
      enabled_memory_monitor  = false
      enabled_service_monitor = true
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_datadog"></a> [datadog](#requirement\_datadog) | >= 3.46 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_http_check"></a> [http\_check](#module\_http\_check) | ../monitors | n/a |
| <a name="module_k8s"></a> [k8s](#module\_k8s) | ../monitors | n/a |
| <a name="module_resource"></a> [resource](#module\_resource) | ../monitors | n/a |
| <a name="module_service"></a> [service](#module\_service) | ../monitors | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The Kubernetes cluster name | `string` | n/a | yes |
| <a name="input_enabled_modules"></a> [enabled\_modules](#input\_enabled\_modules) | List of modules to enable, must be one of http\_check, k8s, resource, service. | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where the resources will be created. | `string` | n/a | yes |
| <a name="input_notification_slack_channel_prefix"></a> [notification\_slack\_channel\_prefix](#input\_notification\_slack\_channel\_prefix) | The prefix for Slack channels that will receive notifcations and alerts | `string` | n/a | yes |
| <a name="input_override_default_monitors"></a> [override\_default\_monitors](#input\_override\_default\_monitors) | Override default monitors with custom configuration | `map(map(any))` | `{}` | no |
| <a name="input_service_names"></a> [service\_names](#input\_service\_names) | n/a | <pre>map(object({<br/>    enabled_cpu_monitor      = optional(bool)<br/>    enabled_memory_monitor   = optional(bool)<br/>    enabled_pods_monitor     = optional(bool)<br/>    enabled_service_monitor  = optional(bool)<br/>    overwrite_container_name = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_tag_slack_channel"></a> [tag\_slack\_channel](#input\_tag\_slack\_channel) | Whether to tag the Slack channel in the message | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->