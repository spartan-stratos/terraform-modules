module "cluster" {
  source = "../eks-cluster/modules/cluster"

  environment        = var.environment
  name               = var.name
  private_subnet_ids = var.private_subnet_ids
  public_subnet_ids  = var.public_subnet_ids
  security_group_ids = var.security_group_ids
  vpc_cidr           = var.vpc_cidr
  vpc_id             = var.vpc_id
}
