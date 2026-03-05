
## Candidate Tasks
### 1. Create `Terraform-Parse` Service
- Work diresctory: terraform_parse_service
#### Build and Run
```
docker-compose up -d --build
```
#### Test
```
curl -X POST http://localhost:5000/parse \
  -H "Content-Type: application/json" \
  -d '{"payload": {"properties": {"aws-region": "ap-northeast-1", "bucket-name": "tripla-test-bucket", "acl": "private"}}}' \
  | jq -r '.terraform_content'
```
```
# output
provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "this" {
  bucket = "tripla-test-bucket"
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}
```
#### Troubleshooting: Port 5000 Conflict (macOS)
If you are using a MacBook, you might encounter an error stating that Port 5000 is already in use. This is typically occupied by the macOS AirPlay Receiver service.

- Solution A: Disable AirPlay Receiver
1. Go to System Settings > General > AirPlay & Handoff.
2. Toggle off the AirPlay Receiver.
- Solution B: Change the Port Mapping, you can modify the host port in your docker-compose.yaml
```
ports:
  - "8080:5000" # Change host port to 8080
```
### 2. Revise `Terraform`
- Work diresctory: terraform
#### Changes
- standardize label naming
- add network config `vpc_id` & `subnet_ids` in main and variables
- update eks resource from `node_groups` to `eks_managed_node_groups` for v19
- update `bucket = "tripla-static-assets"` to no hardcode for multiple env
- update `acl = "public-read"` to `private` to follow best practice
- separate different environments referring to main code
#### Local Verification
- used localstack/localstack to plan and apply. 
    - `docker run -d -p 4566:4566 localstack/localstack`
- update providers.tf to redirect endpoint to localhost:4566
- test code
    - `cd envs/local-test`
    - `terraform plan`
#### terraform init locally to obtain module version lock
- it's needed to comment out backend.tf, then you can init module locally and get module lock file.

### 3. Revise `Kubernetes + Helm`
- Work diresctory: helm
#### Changes
- revise templates with normal format.
- use variables instead of hardcoding
- install metrics-server needs in order to see HPA CPU TARGETS.
#### Test
- install release to local docker kubernetes
```
helm install tripla-test .
helm list
kubectl get deploy,hpa,svc    
```
#### Clean up
```
helm uninstall tripla-test
```