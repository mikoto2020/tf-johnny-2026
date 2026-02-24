# Terraform-Parse API Service
This is a Python/Flask based API service for converting JSON payloads into standard Terraform configuration files.

## Quick Start

Start the service using Docker Compose:
```
docker-compose up -d
```

## Troubleshooting: Port 5000 Conflict (macOS)
If you are using a MacBook, you might encounter an error stating that Port 5000 is already in use. This is typically occupied by the macOS AirPlay Receiver service.

- Solution A: Disable AirPlay Receiver
1. Go to System Settings > General > AirPlay & Handoff.
2. Toggle off the AirPlay Receiver.
- Solution B: Change the Port Mapping, you can modify the host port in your docker-compose.yaml
```
ports:
  - "8080:5000" # Change host port to 8080
```
## Usage: Generating Terraform Files
```
curl -X POST http://localhost:5000/parse \
  -H "Content-Type: application/json" \
  -d '{ "region": "eu-west-1", "bucket_name": "tripla-bucket" }' \
  | jq -r '.terraform_content' > output.tf

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
}
```
