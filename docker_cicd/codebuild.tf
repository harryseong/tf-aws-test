resource "aws_codebuild_project" "codebuild_project" {
  name           = "${var.microservice}-${var.env}"
  description    = "CodeBuild project for ${var.microservice}."
  build_timeout  = "15"
  queued_timeout = "30"
  service_role   = aws_iam_role.codebuild_role.arn
  tags           = local.tags

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "ENVIRONMENT"
      value = var.env
    }

    environment_variable {
      name  = "DOCKER_REPO"
      value = var.docker_codepipeline_config.docker_repo
    }

    environment_variable {
      name  = "ECR_REPO"
      value = var.docker_codepipeline_config.ecr_repo
    }

    environment_variable {
      name  = "IMAGE_NAME"
      value = var.docker_codepipeline_config.image_name
    }

    environment_variable {
      name  = "IMAGE_REPO_TAG"
      value = var.docker_codepipeline_config.image_repo_tag
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("${path.module}/src/buildspec.yaml")
  }
}
