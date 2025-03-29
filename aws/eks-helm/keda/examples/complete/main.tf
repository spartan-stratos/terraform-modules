module "keda" {
  source = "../.."

  oidc_provider = {
    url = "arn:aws:iam::000000000000:oidc-provider/oidc.eks.us-west-2.amazonaws.com/id/14BAEE13AC4C24FC396BE87C8DF5XXXX"
    arn = "oidc.eks.us-west-2.amazonaws.com/id/14BAEE13AC4C24FC396BE87C8DF5XXXX"
  }

  node_selector       = {}
  tolerations         = []
}
