provider "aws" {
  region = "us-west-2"
}

module "vanta" {
  source = "../.."

  providers = {
    aws = aws.global
  }

  vanta_scanner_external_id = "GET_THIS_FROM_VANTA"
}
