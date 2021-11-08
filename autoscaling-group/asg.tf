module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "4.7.0"

  # Autoscaling Group:
  name                      = local.asg_configs.name
  min_size                  = local.asg_configs.min_size
  max_size                  = local.asg_configs.max_size
  desired_capacity          = local.asg_configs.desired_capacity
  wait_for_capacity_timeout = local.asg_configs.wait_for_capacity_timeout
  health_check_type         = local.asg_configs.health_check_type
  vpc_zone_identifier       = local.asg_configs.vpc_zone_identifier

  initial_lifecycle_hooks = local.initial_lifecycle_hooks

  # Launch Template:
  lt_name                            = local.launch_template_configs.lt_name
  description                        = local.launch_template_configs.description
  update_default_version             = local.launch_template_configs.update_default_version
  use_lt                             = local.launch_template_configs.use_lt
  create_lt                          = local.launch_template_configs.create_lt
  image_id                           = local.launch_template_configs.image_id
  instance_type                      = local.launch_template_configs.instance_type
  ebs_optimized                      = local.launch_template_configs.ebs_optimized
  enable_monitoring                  = local.launch_template_configs.enable_monitoring
  block_device_mappings              = local.launch_template_configs.block_device_mappings
  capacity_reservation_specification = local.launch_template_configs.capacity_reservation_specification
  cpu_options                        = local.launch_template_configs.cpu_options
  credit_specification               = local.launch_template_configs.credit_specification
  instance_market_options            = local.launch_template_configs.instance_market_options
  metadata_options                   = local.launch_template_configs.metadata_options
  network_interfaces                 = local.launch_template_configs.network_interfaces
  placement                          = local.launch_template_configs.placement

  tags = [
    local.tags
  ]
}
