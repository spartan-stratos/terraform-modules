module "mwaa" {
  source = "../.."

  name                  = "example-mwaa-environment"
  private_subnet_ids    = ["subnet-12345", "subnet-67890"]
  source_bucket_arn     = "arn:aws:s3:::example-bucket"
  create_iam_role       = true
  create_s3_bucket      = true
  dag_s3_path           = "dags"
  environment_class     = "mw1.medium"
  webserver_access_mode = "PRIVATE_ONLY"
  tags = {
    Environment = "Dev"
  }
}