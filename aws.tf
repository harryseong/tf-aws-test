provider "aws" {
  region = local.region

  default_tags {
    tags = {
      Automation    = "Terraform"
      AutomationKey = "tf-aws-test-main"
    }
  }
}

locals {
  region = "us-east-1"
}
