# main provider
provider "aws" {
  region = var.aws_region
}

# test provider 
# provider "aws" {
#   region = var.aws_region

#   access_key                  = "test"
#   secret_key                  = "test"
  
#   skip_credentials_validation = true
#   skip_metadata_api_check     = true
#   skip_requesting_account_id  = true

#   endpoints {
#     s3     = "http://localhost:4566"
#     sts    = "http://localhost:4566"
#     eks    = "http://localhost:4566"
#     iam    = "http://localhost:4566"
#     ec2    = "http://localhost:4566"
#   }

# }


