module "provider" {
  source  = "c0x12c/oidc-provider/aws"
  version = "1.0.1"

  url                    = var.url
  client_id_list         = var.client_id_list
  additional_thumbprints = var.additional_thumbprints
  create_provider        = var.create_provider
}
