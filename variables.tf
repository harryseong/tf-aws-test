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

variable "domain_name" {
  description = "Domain name of application. Ex: 'harryseong.com'"
  type        = string
}

variable "public_hosted_zone_domain_name" {
  description = "Public hosted zone domain name."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "vpc_default_sg_name" {
  description = "Default VPC security group name."
  type        = string
}

variable "codestarconnections_arn" {
  description = "Codestartconnections ARN for GitHub repository."
  type        = string
}

variable "docker_codepipeline_configs" {
  description = "Map of Docker CodePipeline configs to setup CICD."
  type = map(object({
    git_repo       = string
    git_branch     = string
    docker_repo    = string
    ecr_repo       = string
    image_name     = string
    image_repo_tag = string
  }))
}
