terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "tripla-assignment/dev/terraform.tfstate" # dev tfstate path
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-lock"
  }
}