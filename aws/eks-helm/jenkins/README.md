<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.75.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.16.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.33 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.75.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.16.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.33 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_efs_access_point.jenkins_home](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [helm_release.jenkins](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_persistent_volume.jenkins_home](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/persistent_volume) | resource |
| [kubernetes_persistent_volume_claim.jenkins_home](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/persistent_volume_claim) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_plugins"></a> [additional\_plugins](#input\_additional\_plugins) | List of additional Jenkins plugins to install | `list(string)` | <pre>[<br/>  "ansicolor:1.0.4",<br/>  "blueocean:1.27.13",<br/>  "config-file-provider:973.vb_a_80ecb_9a_4d0",<br/>  "credentials:1378.v81ef4269d764",<br/>  "dark-theme:439.vdef09f81f85e",<br/>  "extended-read-permission:53.v6499940139e5",<br/>  "github:1.39.0",<br/>  "github-oauth:597.ve0c3480fcb_d0",<br/>  "google-login:109.v022b_cf87b_e5b_",<br/>  "http_request:1.18",<br/>  "job-dsl:1.87",<br/>  "matrix-auth:3.2.2",<br/>  "nodejs:1.6.1",<br/>  "oidc-provider:62.vd67c19f76766",<br/>  "pipeline-stage-view:2.34",<br/>  "pipeline-utility-steps:2.16.2",<br/>  "role-strategy:727.vd344b_eec783d",<br/>  "slack:722.vd07f1ea_7ff40",<br/>  "sonar:2.17.2",<br/>  "sshd:3.330.vc866a_8389b_58",<br/>  "theme-manager:262.vc57ee4a_eda_5d",<br/>  "timestamper:1.27",<br/>  "ws-cleanup:0.46"<br/>]</pre> | no |
| <a name="input_admin_alias"></a> [admin\_alias](#input\_admin\_alias) | The alias of Jenkins admin | `string` | `"Spartan"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The Jenkins chart version | `string` | `"5.2.2"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The root domain of project | `string` | n/a | yes |
| <a name="input_efs_id"></a> [efs\_id](#input\_efs\_id) | EFS is for mounting Jenkins home | `string` | n/a | yes |
| <a name="input_efs_jenkins_access_point"></a> [efs\_jenkins\_access\_point](#input\_efs\_jenkins\_access\_point) | EFS is for mounting Jenkins home | `string` | `"/jenkins-home"` | no |
| <a name="input_efs_storage_class_name"></a> [efs\_storage\_class\_name](#input\_efs\_storage\_class\_name) | EFS storage class of Jenkins volume | `string` | `"efs"` | no |
| <a name="input_efs_volume_size"></a> [efs\_volume\_size](#input\_efs\_volume\_size) | EFS volume size | `string` | `"30Gi"` | no |
| <a name="input_enabled_dark_them"></a> [enabled\_dark\_them](#input\_enabled\_dark\_them) | Enable dark theme | `bool` | `false` | no |
| <a name="input_enabled_datadog"></a> [enabled\_datadog](#input\_enabled\_datadog) | Enable Datadog monitoring | `bool` | `true` | no |
| <a name="input_enabled_github_app_login"></a> [enabled\_github\_app\_login](#input\_enabled\_github\_app\_login) | Enable Github App login, only one of Github App login or Google login can be enabled | `bool` | `false` | no |
| <a name="input_enabled_google_login"></a> [enabled\_google\_login](#input\_enabled\_google\_login) | Enable Google login, only one of Github App login or Google login can be enabled | `bool` | `false` | no |
| <a name="input_enabled_init_scripts"></a> [enabled\_init\_scripts](#input\_enabled\_init\_scripts) | Enable init scripts | `bool` | `true` | no |
| <a name="input_enabled_slack_notification"></a> [enabled\_slack\_notification](#input\_enabled\_slack\_notification) | Enable Slack notification | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | n/a | yes |
| <a name="input_general_secrets"></a> [general\_secrets](#input\_general\_secrets) | Secrets are shared across all repos | `map(string)` | n/a | yes |
| <a name="input_github_app_credential_id"></a> [github\_app\_credential\_id](#input\_github\_app\_credential\_id) | GitHub App credentials key for jenkins | `string` | `"github-credentials"` | no |
| <a name="input_github_app_oauth_client_id"></a> [github\_app\_oauth\_client\_id](#input\_github\_app\_oauth\_client\_id) | The Client ID of Spartan SSO | `string` | `""` | no |
| <a name="input_github_app_oauth_client_secret"></a> [github\_app\_oauth\_client\_secret](#input\_github\_app\_oauth\_client\_secret) | The Client Secret of Spartan SSO | `string` | `""` | no |
| <a name="input_github_credential_id"></a> [github\_credential\_id](#input\_github\_credential\_id) | GitHub credentials key for jenkins | `string` | n/a | yes |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | The Github org name | `string` | n/a | yes |
| <a name="input_github_org_display_name"></a> [github\_org\_display\_name](#input\_github\_org\_display\_name) | The Github org display name | `string` | `"Spartan"` | no |
| <a name="input_google_oauth_client_id"></a> [google\_oauth\_client\_id](#input\_google\_oauth\_client\_id) | The Client ID of Google SSO | `string` | `""` | no |
| <a name="input_google_oauth_client_secret"></a> [google\_oauth\_client\_secret](#input\_google\_oauth\_client\_secret) | The Client Secret of Google SSO | `string` | `""` | no |
| <a name="input_google_user_list"></a> [google\_user\_list](#input\_google\_user\_list) | List users and roles for accessing Jenkins | `map(list(string))` | `null` | no |
| <a name="input_ingress_class_name"></a> [ingress\_class\_name](#input\_ingress\_class\_name) | The ingress class name of Jenkins ingress | `string` | `"alb"` | no |
| <a name="input_ingress_group_name"></a> [ingress\_group\_name](#input\_ingress\_group\_name) | The ingress group name of Jenkins ingress | `string` | `"external"` | no |
| <a name="input_install_plugins"></a> [install\_plugins](#input\_install\_plugins) | List of Jenkins plugins to install | `list(string)` | <pre>[<br/>  "configuration-as-code:1836.vccda_4a_122a_a_e",<br/>  "git:5.2.2",<br/>  "kubernetes:4246.v5a_12b_1fe120e",<br/>  "workflow-aggregator:596.v8c21c963d92d"<br/>]</pre> | no |
| <a name="input_jenkins_admins"></a> [jenkins\_admins](#input\_jenkins\_admins) | List of Jenkins admins | `list(string)` | `[]` | no |
| <a name="input_jenkins_base_agent_image_name"></a> [jenkins\_base\_agent\_image\_name](#input\_jenkins\_base\_agent\_image\_name) | The base image for Jenkins agents | `string` | n/a | yes |
| <a name="input_jenkins_base_agent_image_repo"></a> [jenkins\_base\_agent\_image\_repo](#input\_jenkins\_base\_agent\_image\_repo) | The base image for Jenkins agents | `string` | n/a | yes |
| <a name="input_jenkins_base_agent_image_tag"></a> [jenkins\_base\_agent\_image\_tag](#input\_jenkins\_base\_agent\_image\_tag) | The base image for Jenkins agents | `string` | n/a | yes |
| <a name="input_jenkins_cpu"></a> [jenkins\_cpu](#input\_jenkins\_cpu) | The CPU request and limit for Jenkins | `string` | `"1950m"` | no |
| <a name="input_jenkins_dns_name"></a> [jenkins\_dns\_name](#input\_jenkins\_dns\_name) | The Jenkins DNS name | `string` | `"jenkins"` | no |
| <a name="input_jenkins_env_var"></a> [jenkins\_env\_var](#input\_jenkins\_env\_var) | Jenkins environment variables | `string` | `null` | no |
| <a name="input_jenkins_executors"></a> [jenkins\_executors](#input\_jenkins\_executors) | List of Jenkins executors | `list(string)` | `[]` | no |
| <a name="input_jenkins_fqdn"></a> [jenkins\_fqdn](#input\_jenkins\_fqdn) | FQDN of Jenkins service | `string` | `""` | no |
| <a name="input_jenkins_memory"></a> [jenkins\_memory](#input\_jenkins\_memory) | The memory request and limit for Jenkins | `string` | `"4.5Gi"` | no |
| <a name="input_jenkins_shared_lib_repo"></a> [jenkins\_shared\_lib\_repo](#input\_jenkins\_shared\_lib\_repo) | The Jenkins shared library repo | `string` | n/a | yes |
| <a name="input_kaniko_version"></a> [kaniko\_version](#input\_kaniko\_version) | Version of Kaniko build tool | `string` | `"v1.21.1"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"jenkins"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to install Jenkins. Default is jenkins | `string` | `"jenkins"` | no |
| <a name="input_shared_lib_name"></a> [shared\_lib\_name](#input\_shared\_lib\_name) | The name Jenkins uses to name the shared library | `string` | `"spartan"` | no |
| <a name="input_slack_bot_token"></a> [slack\_bot\_token](#input\_slack\_bot\_token) | The slack bot token | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->