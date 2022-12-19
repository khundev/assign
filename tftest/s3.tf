terraform {
  backend "s3" {
  bucket = "khun-s3-tfstate"
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

resource "aws_s3_bucket" "web" {
  bucket = "s3-web-content"
  tags = {
    Name        = "web-bucket"
    Environment = "Dev"
  }

}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.web.id
  key    = "index.html"
  source = "./index.html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("index.html")
}

resource "aws_s3_bucket_acl" "s3_web_bucket_acl" {
  bucket = aws_s3_bucket.web.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "s3_web_bucket_versioning" {
  bucket = aws_s3_bucket.web.id
  versioning_configuration {
    status = "Enabled"
  }
}
