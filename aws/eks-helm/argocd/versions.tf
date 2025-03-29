terraform {
  required_version = ">= 1.10"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.36"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.17.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.88.0"
    }
  }
}
