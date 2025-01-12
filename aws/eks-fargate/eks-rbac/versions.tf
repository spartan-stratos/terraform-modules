terraform {
  required_version = ">= 1.9.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.75.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.33"
    }
  }
}