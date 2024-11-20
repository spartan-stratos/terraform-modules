terraform {
  required_version = "~> 1.9.8"

  required_providers {
    kubernetes = {
      source  = "registry.terraform.io/hashicorp/kubernetes"
      version = ">= 2.33.0"
    }
  }
}