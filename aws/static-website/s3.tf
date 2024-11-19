module "s3" {
  source      = "./modules/s3"
  environment = var.environment
  name        = var.name
  stack_name  = var.stack_name
}
