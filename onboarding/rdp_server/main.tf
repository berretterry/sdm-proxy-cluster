terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}