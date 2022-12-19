terraform {
  backend "s3" {
  bucket = "terraform.tfstate"
  key = "terraform.tfstate"
  region = "ap-southeast-1"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.47.0"
    }
  }
}

# Provider Block
provider "aws" {
  region  = "ap-southeast-1"
  profile = "default"
}
