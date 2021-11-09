module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "4.7.0"

  # Autoscaling Group:
  name            = local.asg_configs.name
  create_asg      = local.asg_configs.create_asg
  create_schedule = local.asg_configs.create_schedule
  force_delete    = local.asg_configs.force_delete

  min_size                  = local.asg_configs.min_size
  max_size                  = local.asg_configs.max_size
  desired_capacity          = local.asg_configs.desired_capacity
  wait_for_capacity_timeout = local.asg_configs.wait_for_capacity_timeout

  target_group_arns     = local.asg_configs.target_group_arns
  wait_for_elb_capacity = local.asg_configs.wait_for_elb_capacity

  vpc_zone_identifier       = local.asg_configs.vpc_zone_identifier
  health_check_type         = local.asg_configs.health_check_type
  health_check_grace_period = local.asg_configs.health_check_grace_period
  enabled_metrics           = local.asg_configs.enabled_metrics
  termination_policies      = local.asg_configs.termination_policies
  initial_lifecycle_hooks   = local.asg_configs.initial_lifecycle_hooks

  # Launch Template:
  lt_name                = local.launch_template_configs.lt_name
  lt_version             = local.launch_template_configs.lt_version
  create_lt              = local.launch_template_configs.create_lt
  description            = local.launch_template_configs.description
  update_default_version = local.launch_template_configs.update_default_version
  use_lt                 = local.launch_template_configs.use_lt
  tags                   = [local.tags]

  # Launch Template - EC2:
  image_id                  = local.launch_template_configs.image_id
  instance_type             = local.launch_template_configs.instance_type
  iam_instance_profile_name = local.launch_template_configs.iam_instance_profile_name
  ebs_optimized             = local.launch_template_configs.ebs_optimized
  enable_monitoring         = local.launch_template_configs.enable_monitoring
  block_device_mappings     = local.launch_template_configs.block_device_mappings
  credit_specification      = local.launch_template_configs.credit_specification
  instance_market_options   = local.launch_template_configs.instance_market_options
  metadata_options          = local.launch_template_configs.metadata_options
  network_interfaces        = local.launch_template_configs.network_interfaces
  user_data_base64          = local.launch_template_configs.user_data_base64
}
