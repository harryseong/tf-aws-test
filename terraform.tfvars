env          = "test"
project_name = "docker-cicd"
domain_name  = "harryseong.com"

public_hosted_zone_domain_name = "harryseong.com"
vpc_id                         = "vpc-09d0d6f0b3b7a7116"
vpc_default_sg_name            = "default"
codestarconnections_arn        = "arn:aws:codestar-connections:us-east-1:552566233886:connection/c534edd6-5a92-41f7-948f-dd940b751d4f"

docker_codepipeline_configs = {
  "template-microservice" = {
    git_repo        = "harryseong/template-microservice"
    git_branch      = "main"
    image_repo_name = "harryseong/template-microservice"
    image_repo_tag  = "0.0.4"
  }
}
