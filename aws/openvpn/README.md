# AWS OpenVPN Terraform module

Terraform module which creates OpenVPN to access internal VPC network.

## Usage

### Create an OpenVPN instance

```hcl
module "openvpn" {
  source = "github.com/spartan-stratos/terraform-modules//aws/openvpn?ref=v0.1.13"

  vpn_name    = "openvpn"
  domain_name = "example.com"

  vpc_id    = "vpc-123456789"
  subnet_id = "subnet-123456789"
  extra_sg_ids = ["sg-123456789"]

  oauth2_client_id     = "google_client_id"
  oauth2_client_secret = "google_client_secret"
}
```

## Examples

- [Example](./examples/complete/)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version  |
|---------------------------------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | >= 5.75  |
| <a name="requirement_random"></a> [random](#requirement\_random)          | >= 3.6.3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls)                   | >= 4.0.6 |

## Providers

| Name                                                       | Version  |
|------------------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws)          | >= 5.75  |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.6.3 |
| <a name="provider_tls"></a> [tls](#provider\_tls)          | >= 4.0.6 |

## Modules

No modules.

## Resources

| Name                                                                                                                                  | Type        |
|---------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)                                       | resource    |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                             | resource    |
| [aws_key_pair.management_ssh_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair)               | resource    |
| [aws_route53_record.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)                  | resource    |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                 | resource    |
| [aws_security_group_rule.egress_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource    |
| [aws_security_group_rule.http_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)   | resource    |
| [aws_security_group_rule.https_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)  | resource    |
| [aws_security_group_rule.udp_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)    | resource    |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)                       | resource    |
| [tls_cert_request.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request)                   | resource    |
| [tls_locally_signed_cert.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert)     | resource    |
| [tls_private_key.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key)                         | resource    |
| [tls_private_key.management_ssh_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key)         | resource    |
| [tls_private_key.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key)                     | resource    |
| [tls_self_signed_cert.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert)               | resource    |
| [aws_ami.debian](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)                                  | data source |
| [aws_route53_zone.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone)                | data source |

## Inputs

| Name                                                                                                                      | Description                                          | Type           | Default                               | Required |
|---------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|----------------|---------------------------------------|:--------:|
| <a name="input_disk_boot_size"></a> [disk\_boot\_size](#input\_disk\_boot\_size)                                          | The size of the boot disk in GB.                     | `number`       | `"10"`                                |    no    |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name)                                                     | The domain name.                                     | `string`       | n/a                                   |   yes    |
| <a name="input_extra_sg_ids"></a> [extra\_sg\_ids](#input\_extra\_sg\_ids)                                                | A list of additional security group IDs.             | `list(string)` | `[]`                                  |    no    |
| <a name="input_image_distro"></a> [image\_distro](#input\_image\_distro)                                                  | The distribution of the image.                       | `string`       | `"debian-12-amd64"`                   |    no    |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version)                                               | The version of the image.                            | `string`       | `"20240717-1811"`                     |    no    |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type)                                               | The type of the instance.                            | `string`       | `"t3.micro"`                          |    no    |
| <a name="input_oauth2_client_id"></a> [oauth2\_client\_id](#input\_oauth2\_client\_id)                                    | The OAuth2 client ID.                                | `string`       | n/a                                   |   yes    |
| <a name="input_oauth2_client_secret"></a> [oauth2\_client\_secret](#input\_oauth2\_client\_secret)                        | The OAuth2 client secret.                            | `string`       | n/a                                   |   yes    |
| <a name="input_openvpn_auth_oauth2_version"></a> [openvpn\_auth\_oauth2\_version](#input\_openvpn\_auth\_oauth2\_version) | The version of OpenVPN OAuth2 authentication plugin. | `string`       | `"1.22.4"`                            |    no    |
| <a name="input_openvpn_fqdn"></a> [openvpn\_fqdn](#input\_openvpn\_fqdn)                                                  | The fully qualified domain name of the OpenVPN.      | `string`       | `""`                                  |    no    |
| <a name="input_openvpn_ip_pool"></a> [openvpn\_ip\_pool](#input\_openvpn\_ip\_pool)                                       | The IP pool for OpenVPN clients.                     | `string`       | `"10.8.0.0"`                          |    no    |
| <a name="input_organization"></a> [organization](#input\_organization)                                                    | The name of the organization.                        | `string`       | `"Spartan"`                           |    no    |
| <a name="input_route_network_cidrs"></a> [route\_network\_cidrs](#input\_route\_network\_cidrs)                           | A list of network CIDRs to route.                    | `list(string)` | <pre>[<br/>  "10.0.0.0/8"<br/>]</pre> |    no    |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id)                                                           | The ID of the subnet.                                | `string`       | n/a                                   |   yes    |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id)                                                                    | The ID of the VPC.                                   | `string`       | n/a                                   |   yes    |
| <a name="input_vpn_name"></a> [vpn\_name](#input\_vpn\_name)                                                              | The name of the VPN.                                 | `string`       | `"openvpn"`                           |    no    |

## Outputs

| Name                                                                                  | Description |
|---------------------------------------------------------------------------------------|-------------|
| <a name="output_ovpn_file"></a> [ovpn\_file](#output\_ovpn\_file)                     | n/a         |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip)                     | n/a         |
| <a name="output_ssh_private_key"></a> [ssh\_private\_key](#output\_ssh\_private\_key) | n/a         |
| <a name="output_ssh_public_key"></a> [ssh\_public\_key](#output\_ssh\_public\_key)    | n/a         |
