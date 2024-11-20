module "redis" {
  source = "../../"

  cluster_name                           = "example"
  environment                            = "dev"
  subnet_ids                             = ["subnet-1234567899a", "subnet-1234567899b"]
  node_type                              = "cache.t3.micro"
  cache_node_count                       = 1
  security_group_allow_all_within_vpc_id = "sg-1234567899"
}