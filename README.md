# coffee-tf
Terraform code repo for coffee app.

## Manual Steps:
1. [Terraform Code] Set all CloudFront Route53 record module "create" attribute to "false" for 1st run of "terraform apply".

2. Run "terraform apply".

3. [Terraform Code] Set all CloudFront Route53 record module "create" attribute to "true" for 2nd run of "terraform apply".

4. Run "terraform apply".
