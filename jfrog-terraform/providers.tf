terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    artifactory = {
      source  = "jfrog/artifactory"
      version = "6.9.3"
    }
    xray = {
      source  = "registry.terraform.io/jfrog/xray"
      version = "1.1.6"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "artifactory" {
  url = "https://.jfrog.io"
  access_token = var.token
}

provider "xray" {
  url = "https://.jfrog.io/xray"
  access_token = var.token
}

variable "token" {
  default = ""
}