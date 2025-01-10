module "vanta" {
  source = "../.."

  providers = {
    aws.global = aws.global
  }
}