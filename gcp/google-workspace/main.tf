module "group" {
  source = "./modules/group"

  for_each = var.groups

  description = each.value.description
  domain      = var.domain
  identifier  = each.key
  members     = each.value.members
  name        = each.value.name
}
