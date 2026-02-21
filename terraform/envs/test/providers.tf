provider "aws" {
  region                      = "ap-northeast-1"
  # LocalStack does not require a real key, just fill in the mock value
  access_key                  = "test"
  secret_key                  = "test"
  
  # Skip the verification required in the real environment and speed up local startup
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # Redirect endpoint to local LocalStack
  endpoints {
    s3     = "http://localhost:4566"
    sts    = "http://localhost:4566"
    eks    = "http://localhost:4566"
    iam    = "http://localhost:4566"
    ec2    = "http://localhost:4566"
  }
}