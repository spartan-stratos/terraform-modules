module "sqs" {
  source            = "../../"
  name              = "example-queue"
  max_receive_count = 1
  principal_roles   = ["arn:aws:iam::<account-id>:role/sqs-role"]
  aws_account_id    = "<account-id>"
  aws_region        = "us-west1"
}
