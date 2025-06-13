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
  }

    backend "s3" {
      bucket = "bterry-lab"
      key = "bterry-lab/terraform.tfstate"
      region = "us-west-2"
    }
}

provider "aws" {
  profile = "berretterry"
  region = var.aws_region
}
