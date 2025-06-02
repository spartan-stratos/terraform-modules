<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 6.12 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_monitoring_notification_channel.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_token"></a> [auth\_token](#input\_auth\_token) | An authorization token for a notification channel. Channel types that support this field include: slack. | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | A short label describing the notification channel, such as 'Production Pager'. | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Configuration fields that define the channel behavior. The `email_address` key is required for type 'email', for example. | `map(string)` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | An password for a notification channel. Channel types that support this field include : webhook\_basicauth. | `string` | `null` | no |
| <a name="input_service_key"></a> [service\_key](#input\_service\_key) | An service key token for a notification channel. Channel types that support this field include : pagerduty. | `string` | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of the notification channel. Supported values include: 'email', 'sms', 'slack', 'webhook', etc. (see GCP docs for full list). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END_TF_DOCS -->
