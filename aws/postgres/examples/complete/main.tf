module "postgresql" {
  source = "../../"

  db_identifier                          = "example-rds"
  db_name                                = "example_rds"
  db_username                            = "exampleuser"
  instance_class                         = "db.t3.micro"
  disk_size                              = 10
  environment                            = "dev"
  iam_database_authentication_enabled    = false
  replica_count                          = 0
  security_group_allow_all_within_vpc_id = "sg-1234567899"
  subnet_ids                             = []
  postgresql_password_secret_id          = "secret-123456789"
}
