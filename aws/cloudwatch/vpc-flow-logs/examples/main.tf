module "vpc_flow_logs" {
  source = "../"

  vpc_id            = "vpc-12345678"
  group_name        = "spatan-stratos"
  traffic_type      = "ALL"
  retention_in_days = 10
}
