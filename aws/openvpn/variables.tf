
variable "vpn_name" {
  type = string
  description = "The name of the VPN."
  default = "openvpn"
}

variable "instance_type" {
  type = string
  description = "The type of the instance."
  default = "t3.micro"
}

variable "vpc_id" {
  type = string
  description = "The ID of the VPC."
}

variable "subnet_id" {
  type = string
  description = "The ID of the subnet."
}

variable "image_distro" {
  type = string
  description = "The distribution of the image."
  default = "debian-12-amd64"
}

variable "image_version" {
  type = string
  description = "The version of the image."
  default = "20240717-1811"
}

variable "disk_boot_size" {
  type = number
  description = "The size of the boot disk in GB."
  default = "10"
}

variable "domain_name" {
  type = string
  description = "The domain name."
}

variable "organization" {
  type = string
  description = "The name of the organization."
  default = "Spartan"
}

variable "openvpn_fqdn" {
  type = string
  description = "The fully qualified domain name of the OpenVPN."
  default = ""
}

variable "extra_sg_ids" {
  type = list(string)
  description = "A list of additional security group IDs."
  default = []
}

variable "openvpn_ip_pool" {
  type = string
  description = "The IP pool for OpenVPN clients."
  default = "10.8.0.0"
}

variable "route_network_cidrs" {
  type = list(string)
  description = "A list of network CIDRs to route."
  default = ["10.0.0.0/8"]
}

variable "openvpn_auth_oauth2_version" {
  type = string
  description = "The version of OpenVPN OAuth2 authentication plugin."
  default = "1.22.4"
}

variable "oauth2_client_id" {
  type = string
  description = "The OAuth2 client ID."
}

variable "oauth2_client_secret" {
  type = string
  description = "The OAuth2 client secret."
}
