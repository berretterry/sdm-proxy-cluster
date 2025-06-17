terraform {
  required_version = ">= 0.14.0"
  required_providers {
    sdm = {
      source = "strongdm/sdm"
      version = ">= 14.20.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = ">= 6.0.0-beta3"
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
  region = module.onboarding.aws_region
}

