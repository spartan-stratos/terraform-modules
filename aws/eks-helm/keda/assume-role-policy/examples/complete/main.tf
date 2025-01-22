module "keda-assume-role-policy" {
  source = "../.."

  keda_operator_role_arn = "arn:aws:iam::000000000000:role/keda-operator"
  assume_role_arns = [
    "arn:aws:iam::000000000000:role/service-platform-eksPodRole"
  ]
}
