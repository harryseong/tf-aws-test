variable "env" {
  description = "Environment. Values: ['dev', 'test', 'prod']"
  type        = string
}

variable "project_name" {
  description = "Project name. Ex: 'harryseong'"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "vpc_private_subnet_ids" {
  description = "Private subnet IDs."
  type        = list(string)
}

variable "vpc_default_sg_name" {
  description = "Default VPC security group name."
  type        = string
}
