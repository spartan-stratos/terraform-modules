module "neo4j" {
  source = "../.."

  efs_id = "example-id"
  domain = "example.com"
}
