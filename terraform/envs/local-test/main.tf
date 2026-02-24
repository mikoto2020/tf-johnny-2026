# Call the resource definition of the parent directory
module "local_infrastructure" {
  source = "../../"

  # Pass in variables for testing
  aws_region   = "ap-northeast-1"
  environment  = "local-test"
  cluster_name = "test-cluster"
  
  # When testing locally, these IDs only need to be in the correct format
  vpc_id       = "vpc-12345678"
  subnet_ids   = ["subnet-12345", "subnet-67890"]
}

# Inherit output to verify results
output "test_s3_bucket" {
  value = module.local_infrastructure.s3_bucket_name
}