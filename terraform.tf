terraform {
  backend "s3" {
    bucket         = "terraform-states-552566233886-us-east-1"
    key            = "tf-aws-test/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-states"
  }
}
