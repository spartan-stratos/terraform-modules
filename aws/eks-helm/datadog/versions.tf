terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.33"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.16.1"
    }
  }
}
