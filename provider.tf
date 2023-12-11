terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  shared_credentials_files = var.aws_credentials
  profile                  = var.aws_profile
  region                   = var.aws_default_region
}
