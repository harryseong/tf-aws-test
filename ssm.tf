locals {
  tags = {
    Environment = var.env
    Application = var.project_name
  }
}

resource "aws_ssm_parameter" "docker_cli_username" {
  name        = "/${var.domain_name}/docker/cli/username"
  description = "Docker CLI username used for Docker CICD."
  type        = "String"
  value       = "default_value"
  overwrite   = false
  tags        = local.tags

  lifecycle {
    ignore_changes  = [value]
    prevent_destroy = true
  }
}

resource "aws_ssm_parameter" "docker_cli_access_token" {
  name        = "/${var.domain_name}/docker/cli/access_token"
  description = "Docker CLI access token used for Docker CICD."
  type        = "SecureString"
  value       = "default_value"
  overwrite   = false
  tags        = local.tags

  lifecycle {
    ignore_changes  = [value]
    prevent_destroy = true
  }
}
