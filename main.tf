terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"

  backend "s3" {
    key = "test/s3_1.tfstat"
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      mail        = var.author_mail
      provided_by = "Terraform"
    }
  }
}
