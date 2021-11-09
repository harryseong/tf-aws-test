module "autoscaling-group" {
  source = "./autoscaling-group"
  env    = "test"

  project_name           = var.project_name
  vpc_id                 = var.vpc_id
  vpc_private_subnet_ids = data.aws_subnet_ids.private.ids
  vpc_default_sg_name    = var.vpc_default_sg_name
}
