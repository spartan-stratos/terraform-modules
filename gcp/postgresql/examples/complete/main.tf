module "postgresql" {
  source = "../../"

  network_name = "example-vpc-name"
  project_id   = "example-project"
  region       = "us-west1"

  db_name  = "example-database"
  name     = "example"
  size     = 20
  username = "example-user"

  replica_count          = 1
  analytic_replica_count = 1
}
