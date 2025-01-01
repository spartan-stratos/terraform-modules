<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_datadog"></a> [datadog](#requirement\_datadog) | >= 3.46.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_datadog"></a> [datadog](#provider\_datadog) | >= 3.46.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [datadog_monitor.this](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/monitor) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the monitors are being created (e.g., dev, staging, prod). | `string` | n/a | yes |
| <a name="input_monitors"></a> [monitors](#input\_monitors) | A map of monitors to create. The key is the monitor name and the value is a map of monitor attributes. The following attributes are required:<br/>    - enabled: Whether the monitor is enabled.<br/>    - priority\_level: The priority level of the monitor.<br/>    - title\_tags: The tags to include in the title of the monitor.<br/>    - title: The title of the monitor.<br/>    - query\_template: The template for the monitor query.<br/>    - query\_args: The arguments for the monitor query.<br/>    - threshold\_critical: The critical threshold for the monitor.<br/>    - threshold\_critical\_recovery: The critical recovery threshold for the monitor.<br/>    - renotify\_interval: The renotify interval for the monitor.<br/><br/>    The following attributes are optional:<br/>    - renotify\_occurrences: The renotify occurrences for the monitor.<br/>    - require\_full\_window: Whether the monitor requires a full window.<br/>    - enabled\_include\_tags: Whether to include tags in the monitor.<br/>    - additional\_tags: Additional tags to include in the monitor.<br/>    - notification\_preset\_name: The notification preset name for the monitor. | <pre>map(object({<br/>    enabled                     = optional(bool, true)<br/>    priority_level              = number<br/>    title_tags                  = string<br/>    title                       = string<br/>    query_template              = string<br/>    query_args                  = map(string)<br/>    threshold_critical          = number<br/>    threshold_critical_recovery = number<br/>    renotify_interval           = number<br/>    renotify_occurrences        = optional(number)<br/>    require_full_window         = optional(bool, true)<br/>    enabled_include_tags        = optional(bool, false)<br/>    additional_tags             = optional(list(string), [])<br/>    notification_preset_name    = optional(string, "hide_all")<br/>  }))</pre> | n/a | yes |
| <a name="input_notification_slack_channel_prefix"></a> [notification\_slack\_channel\_prefix](#input\_notification\_slack\_channel\_prefix) | The prefix for the Slack channel used for notifications. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | The service to monitor. | `string` | n/a | yes |
| <a name="input_tag_slack_channel"></a> [tag\_slack\_channel](#input\_tag\_slack\_channel) | Whether to tag the Slack channel in the notification message. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->