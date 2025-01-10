provider "aws" {
  region = "us-west-2"
}

module "vanta" {
  source = "../.."

  providers = {
    aws = aws.global
  }

  vanta_scanner_external_id = "48831EA4DBFBCDD"
}
