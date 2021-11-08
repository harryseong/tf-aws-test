data "aws_route53_zone" "public_hosted_zone" {
  name         = var.public_hosted_zone_domain_name
  private_zone = false
}

data "aws_security_group" "vpc_default_sg" {
  name   = var.vpc_default_sg_name
  vpc_id = var.vpc_id
}

data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id
  tags   = { "Tier" = "private" }
}
