terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

variable "aws_region" {
  description = "AWS region for Week 36 CI/CD infrastructure"
  type        = string
  default     = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}
# S3 bucket for CI/CD pipeline artifacts
resource "aws_s3_bucket" "artifacts" {
  bucket = "week36-serverless-cicd-artifacts-906446636895-us-east-1"

  tags = {
    Name        = "Week36-CICD-Artifacts"
    Project     = "Week36"
    Environment = "Learning"
  }
}

# Enable bucket versioning
resource "aws_s3_bucket_versioning" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
