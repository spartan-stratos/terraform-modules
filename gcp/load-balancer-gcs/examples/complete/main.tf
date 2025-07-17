module "load_balancer" {
  source = "../.."

  prefix_name = "proj-x"
  bucket_name = "proj-x-static-website"
  enable_http = true
  enable_ssl  = false
  enable_cdn  = true
}