module "eks-access-entry" {
  source = "../"

  aws_account_id = "<account-id>"
  cluster_name   = "example-cluster"
  access_entries = {
    /*
      Role for cluster administrators with full access to the EKS cluster
     */
    admin-role = {
      principal_name = "admin-role"
      policy_arn     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
      trusted_role_arn = [
        "arn:aws:iam::<account-id>:role/aws-reserved/sso.amazonaws.com/us-west-2/SpartanAdministratorAccess",
        "arn:aws:iam::<account-id>:role/aws-reserved/sso.amazonaws.com/us-west-2/SpartanPowerUserAccess"
      ]
    }
    /*
      Role for cluster developers with view-only access to the EKS cluster
     */
    developer-role = {
      principal_name = "developer-role"
      policy_arn     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterViewPolicy"
      trusted_role_arn = [
        "arn:aws:iam::<account-id>:role/aws-reserved/sso.amazonaws.com/us-west-2/SpartanAdministratorAccess"
      ]
    }
    /* 
      Role for managing access to a specific namespace in the EKS cluster
     */
    service-platform-role = {
      principal_name = "service-platform-role"
      policy_arn     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
      trusted_role_arn = [
        "arn:aws:iam::<account-id>:role/aws-reserved/sso.amazonaws.com/us-west-2/SpartanAdministratorAccess"
      ]
      access_type = "namespace"
      namespaces  = ["service-platform"]
    }
    /*
      Pre-existing role used for CI/CD pipelines within GitHub Actions
     */
    role-terraform-ops = {
      principal_name = "github-actions/role-terraform-ops"
      policy_arn     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
    }
  }
}
