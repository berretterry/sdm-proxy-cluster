terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    sdm = {
      source = "strongdm/sdm"
      version = "14.20.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.1.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.37.1"
    }
  }
}

provider "aws" {
  profile = "berretterry"
  region = var.aws_region
}