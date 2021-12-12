# https://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html#action-requirements

resource "aws_codepipeline" "codepipeline" {
  name     = "${var.project_name}-${var.env}-codepipeline"
  role_arn = aws_iam_role.codepipeline_role.arn
  tags     = local.tags

  artifact_store {
    location = module.codepipeline_artifacts_s3_bucket.s3_bucket_id
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = var.codestarconnections_arn
        FullRepositoryId = "harryseong/template-microservice"
        BranchName       = var.env == "prod" ? "main" : var.env
        DetectChanges    = true
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.codebuild_project.id
      }
    }
  }
}
