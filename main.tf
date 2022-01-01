locals {
  create_autoscaling_group = false
  create_docker_cicd       = true
}

module "autoscaling_group" {
  source = "./autoscaling-group"
  count  = local.create_autoscaling_group ? 1 : 0

  env                    = var.env
  project_name           = var.project_name
  vpc_id                 = var.vpc_id
  vpc_private_subnet_ids = data.aws_subnet_ids.private.ids
  vpc_default_sg_name    = var.vpc_default_sg_name
}

module "docker_cicd" {
  source   = "./docker_cicd"
  for_each = local.create_docker_cicd ? var.docker_codepipeline_configs : {}

  env          = "prod"
  project_name = var.project_name
  domain_name  = var.domain_name

  microservice               = each.key
  docker_codepipeline_config = each.value
  codestarconnections_arn    = var.codestarconnections_arn
}
