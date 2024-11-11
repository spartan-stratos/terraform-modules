module "aws_vpc" {
  source = "../../"

  name                        = "example"
  cidr_block                  = "10.1.0.0/16"
  availability_zone_postfixes = ["a", "b", "c"]
  environment                 = "dev"
  single_nat                  = true
  region                      = "us-west-2"
}
