output "public_ip" {
  value = module.public_ip
}

output "ca_cert" {
  value = module.ca_cert
}

output "ssh_public_key" {
  value = module.ssh_public_key
}

output "ovpn_file" {
  value = module.openvpn.ovpn_file
}
