module "eks-access-entry" {
  source = "../"

  environment    = "dev"
  name           = "example-name"
  aws_account_id = "<account-id>"
  access_entries = {
    admin-role = {
      principal_name = "admin-role"
      policy_arn     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
      trusted_role_arn = [
        "arn:aws:iam::<account-id>:role/aws-reserved/sso.amazonaws.com/us-west-2/SpartanAdministratorAccess",
        "arn:aws:iam::<account-id>:role/aws-reserved/sso.amazonaws.com/us-west-2/SpartanPowerUserAccess"
      ]
    }
    developer-role = {
      principal_name = "developer-role"
      policy_arn     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterViewPolicy"
      trusted_role_arn = [
        "arn:aws:iam::<account-id>:role/aws-reserved/sso.amazonaws.com/us-west-2/SpartanAdministratorAccess"
      ]
    }
    service-platform-role = {
      principal_name = "service-platform-role"
      policy_arn     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
      trusted_role_arn = [
        "arn:aws:iam::<account-id>:role/aws-reserved/sso.amazonaws.com/us-west-2/SpartanAdministratorAccess"
      ]
      access_type = "namespace"
      namespaces  = ["service-platform"]
    }
  }
}
