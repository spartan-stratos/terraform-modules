module "vanta" {
  source = "../.."

  providers = {
    aws.global = aws.global
  }

  vanta_scanner_external_id = "48831EA4DBFBCDD"
}
