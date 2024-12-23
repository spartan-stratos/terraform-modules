variable "security_groups" {
  description = "List of security group configurations"
  type = list(object({
    name                = string
    description         = string
    vpc_id              = string
    ingress_rules       = list(string)
    ingress_cidr_blocks = list(string)
    egress_rules        = list(string)
    egress_cidr_blocks  = list(string)
  }))
}

variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))

  default = {
    "allow-ssh"  = [22, 22, "tcp", "Allow SSH access"]
    "allow-http" = [80, 80, "tcp", "Allow HTTP traffic"]
    "allow-all"  = [0, 0, "-1", "Allow all inbound traffic within vpc"]
  }
}
