terraform {
  required_version = ">= 1.9.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.75"
    }

    kubernetes = {
      source  = "registry.terraform.io/hashicorp/kubernetes"
      version = ">= 2.33.0"
    }

    tls = {
      source  = "registry.terraform.io/hashicorp/tls"
      version = ">= 4.0"
    }
  }
}