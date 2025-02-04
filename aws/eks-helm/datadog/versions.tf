terraform {
  required_version = ">= 1.9.8"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.16.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.6"
    }
  }
}
