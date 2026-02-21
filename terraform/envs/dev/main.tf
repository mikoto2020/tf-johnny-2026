module "infrastructure" {
  source = "../../"

  aws_region   = "ap-northeast-1"
  environment  = "dev"
  cluster_name = "tripla-eks-dev"
  vpc_id       = "vpc-0123456789dev"
  subnet_ids   = ["subnet-111", "subnet-222"]
}