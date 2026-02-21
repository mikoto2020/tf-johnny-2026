# Changes
- standardize label naming
- add network config `vpc_id` & `subnet_ids` in main and variables
- update eks resource from `node_groups` to `eks_managed_node_groups` for v19

- update `bucket = "tripla-static-assets"` to no hardcode for multiple env
- update `acl = "public-read"` to `private` to follow best practice
- separate different environments refering to main code
# Verify codes locally
- usu localstack/localstack to plan and apply. 
    - `docker run -d -p 4566:4566 localstack/localstack`
- it's needed to comment provider section in main.tf during testing.
    - `cd envs/test && terraform plan -out=tfplan`
# terraform init locally to obtain module version lock
- it's needed to remark backent.tf, then you can init module locally and get module lock file..
