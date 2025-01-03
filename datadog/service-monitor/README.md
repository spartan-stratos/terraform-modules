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
| <a name="input_create_http_check_monitors"></a> [create\_http\_check\_monitors](#input\_create\_http\_check\_monitors) | Whether HTTP check monitors should be created. Set to 'true' to create the monitors, 'false' to disable. | `bool` | `false` | no |
| <a name="input_create_k8s_monitors"></a> [create\_k8s\_monitors](#input\_create\_k8s\_monitors) | Whether Kubernetes-specific monitors should be created. Set to 'true' to create the monitors, 'false' to disable. | `bool` | `false` | no |
| <a name="input_create_resource_monitors"></a> [create\_resource\_monitors](#input\_create\_resource\_monitors) | Whether resource monitors (e.g., CPU, memory, etc.) should be created. Set to 'true' to create the monitors, 'false' to disable. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment where the resources will be created. | `string` | n/a | yes |
| <a name="input_notification_slack_channel_prefix"></a> [notification\_slack\_channel\_prefix](#input\_notification\_slack\_channel\_prefix) | The prefix for Slack channels that will receive notifcations and alerts | `string` | n/a | yes |
| <a name="input_override_default_monitors"></a> [override\_default\_monitors](#input\_override\_default\_monitors) | A map of overridden monitors. The key is the monitor name and the value is a map of monitor attributes. The following attributes are required:<br/>    - enabled: Whether the monitor is enabled.<br/>    - priority\_level: The priority level of the monitor.<br/>    - title\_tags: The tags to include in the title of the monitor.<br/>    - title: The title of the monitor.<br/>    - type: The type of the monitor.<br/>    - query\_template: The template for the monitor query.<br/>    - query\_args: The arguments for the monitor query.<br/>    - threshold\_critical: The critical threshold for the monitor.<br/>    - threshold\_critical\_recovery: The critical recovery threshold for the monitor.<br/>    - threshold\_ok: The recovery threshold for the monitor. Only supported in monitor type `service check`.<br/>    - renotify\_interval: The renotify interval for the monitor.<br/><br/>    The following attributes are optional:<br/>    - renotify\_occurrences: The renotify occurrences for the monitor.<br/>    - require\_full\_window: Whether the monitor requires a full window.<br/>    - enabled\_include\_tags: Whether to include tags in the monitor.<br/>    - additional\_tags: Additional tags to include in the monitor.<br/>    - notification\_preset\_name: The notification preset name for the monitor. | <pre>map(object({<br/>    enabled                     = optional(bool)<br/>    priority_level              = optional(number)<br/>    title_tags                  = optional(string)<br/>    title                       = optional(string)<br/>    type                        = optional(string)<br/>    query_template              = optional(string)<br/>    query_args                  = optional(map(string))<br/>    threshold_critical          = optional(number)<br/>    threshold_critical_recovery = optional(number)<br/>    threshold_ok                = optional(number)<br/>    renotify_interval           = optional(number)<br/>    renotify_occurrences        = optional(number)<br/>    require_full_window         = optional(bool)<br/>    enabled_include_tags        = optional(bool)<br/>    additional_tags             = optional(list(string))<br/>    notification_preset_name    = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_service_names"></a> [service\_names](#input\_service\_names) | A map of service names and options whether to create corresponding monitors, including CPU, memory, pods, and service monitoring. Additionally, it can specify whether to overwrite the container name to match the query. | <pre>map(object({<br/>    enabled_cpu_monitor      = optional(bool)<br/>    enabled_memory_monitor   = optional(bool)<br/>    enabled_pods_monitor     = optional(bool)<br/>    enabled_service_monitor  = optional(bool)<br/>    overwrite_container_name = optional(string)<br/>  }))</pre> | `null` | no |
| <a name="input_tag_slack_channel"></a> [tag\_slack\_channel](#input\_tag\_slack\_channel) | Whether to tag the Slack channel in the message | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->