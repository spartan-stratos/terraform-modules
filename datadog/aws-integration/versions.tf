terraform {
  required_version = ">= 1.9.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.75"
    }

    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.46.0"
    }
  }
}

provider "datadog" {}