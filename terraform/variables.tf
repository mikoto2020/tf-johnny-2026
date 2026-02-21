variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "cluster_name" {
  type    = string
  default = "tripla-messy-eks"
}

variable "vpc_id" {
  type    = string
  default = ""
  description = "The VPC ID where EKS will be deployed"
}

variable "subnet_ids" {
  type    = list(string)
  default = []
  description = "List of subnet IDs for EKS nodes"
}

variable "environment" {
  type    = string
  default = "dev"
  description = "Environment name (e.g., dev, prod)"
}
