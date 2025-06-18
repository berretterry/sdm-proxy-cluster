terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
    sdm = {
      source = "strongdm/sdm"
      version = "14.20.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}