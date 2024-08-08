
#Backend configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "wemadevops-44657-fantastic"
    region  = "us-west-2"
    key     = "s3/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = var.region
}