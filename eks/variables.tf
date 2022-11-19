variable "env" {
  description = "aws-tf-test environment."
  type        = string
  validation {
    condition     = var.env == "shared" || var.env == "dev" || var.env == "test" || var.env == "prod"
    error_message = "Invalid input. \"var.env\" must be one of the following values: dev|test|prod."
  }
}

variable "project_name" {
  description = "Project name. Ex: 'harryseong'"
  type        = string
}

variable "vpc_private_subnet_ids" {
  description = "Private subnet IDs."
  type        = list(string)
}
