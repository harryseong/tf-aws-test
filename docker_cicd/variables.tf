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

variable "codestarconnections_arn" {
  description = "CodeStarConnections connection ARN."
  type        = string
}

variable "microservice" {
  description = "Name of microservice to build and Dockerize."
  type        = string
}
variable "docker_codepipeline_config" {
  description = "Docker CodePipeline configs required for CICD."
  type = object({
    git_repo       = string
    git_branch     = string
    docker_repo    = string
    ecr_repo       = string
    image_name     = string
    image_repo_tag = string
  })
}
