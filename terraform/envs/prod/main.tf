module "infrastructure" {
  source = "../../"

  aws_region   = "ap-northeast-1"
  environment  = "prod"
  cluster_name = "tripla-eks-prod"
  vpc_id       = "vpc-987654321prod"
  subnet_ids   = ["subnet-aaa", "subnet-bbb"]
}