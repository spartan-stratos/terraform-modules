# Datadog Dashboard module

## Requirements

| Name                                                               | Version |
| ------------------------------------------------------------------ | ------- |
| <a name="requirement_datadog"></a> [datadog](#requirement_datadog) | 3.38.0  |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_datadog"></a> [datadog](#provider_datadog) | 3.38.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                        | Type     |
| --------------------------------------------------------------------------------------------------------------------------- | -------- |
| [datadog_dashboard_json.this](https://registry.terraform.io/providers/DataDog/datadog/3.38.0/docs/resources/dashboard_json) | resource |

## Inputs

| Name                                                                                    | Description                                                                          | Type                                                                                                                                                                          | Default | Required |
| --------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_description"></a> [description](#input_description)                      | The description of the dashboard.                                                    | `string`                                                                                                                                                                      | `null`  |    no    |
| <a name="input_layout_type"></a> [layout_type](#input_layout_type)                      | The layout type of the dashboard. Valid values are ordered, free.                    | `string`                                                                                                                                                                      | n/a     |   yes    |
| <a name="input_notify_list"></a> [notify_list](#input_notify_list)                      | The list of handles for the users to notify when changes are made to this dashboard. | `list(string)`                                                                                                                                                                | `[]`    |    no    |
| <a name="input_reflow_type"></a> [reflow_type](#input_reflow_type)                      | The reflow type of a new dashboard layout. Valid values are auto, fixed.             | `string`                                                                                                                                                                      | `null`  |    no    |
| <a name="input_template_variables"></a> [template_variables](#input_template_variables) | The list of template variables for this powerpack.                                   | <pre>list(object({<br> name = string<br> available_values = optional(list(string), [])<br> default = optional(string, "\*")<br> prefix = optional(string, null)<br> }))</pre> | `[]`    |    no    |
| <a name="input_title"></a> [title](#input_title)                                        | The title of the dashboard.                                                          | `string`                                                                                                                                                                      | n/a     |   yes    |
| <a name="input_widgets"></a> [widgets](#input_widgets)                                  | The list of widgets to display on the dashboard.                                     | `any`                                                                                                                                                                         | `[]`    |    no    |

## Outputs

| Name                                         | Description               |
| -------------------------------------------- | ------------------------- |
| <a name="output_id"></a> [id](#output_id)    | The ID of this resource.  |
| <a name="output_url"></a> [url](#output_url) | The Url of this resource. |
