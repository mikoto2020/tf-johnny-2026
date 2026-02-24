# Unified labels (Locals)
locals {
  common_tags = {
    Project     = "Tripla-Assignment"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# EKS module ref: https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/19.0.0
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.0"

  cluster_name    = "${var.cluster_name}-${var.environment}" # Add environment suffix
  cluster_version = "1.25"
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

# In v19.x, it is recommended to use eks_managed_node_groups
  eks_managed_node_groups = {
    default = {
      min_size      = 1
      max_size      = 3
      desired_size  = 2

      instance_types = ["t3.medium"] 

    }
  }

  tags = local.common_tags
}

# S3 security refactoring
resource "aws_s3_bucket" "static_assets" {
  bucket = "tripla-static-assets-${var.environment}" # Avoid name conflicts
  tags   = local.common_tags
}

# Split ACL resources (AWS 4.x compliant)
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.static_assets.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.this]
  bucket     = aws_s3_bucket.static_assets.id
  acl        = "private" # For security reasons, default to private
}
