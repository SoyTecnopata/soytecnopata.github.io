terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.77"
    }
  }

  required_version = ">= 1"
}