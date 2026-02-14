# README for parse app
- Prot 5000 might be unavailable
    - if your environment is MacBook, port 5000 might be occured by AirPlay, 
    - you can disable AirPlay function or modify exposed port in docker-compose.yaml
- How to get usable tf file
    - use jq command to fetch raw contents as below
    - `curl -X POST {...} | jq -r '.terraform_content' .terraform_content > output.tf`
```
# output.tf
provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "this" {
  bucket = "tripla-bucket"
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}```
