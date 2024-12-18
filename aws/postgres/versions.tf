terraform {
  required_version = ">= 1.9.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.75"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6"
    }
  }
}
