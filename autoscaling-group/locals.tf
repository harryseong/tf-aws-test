locals {
  tags = {
    Environment = var.env
    Application = var.project_name
  }

  ec2_ssm_iam_policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

  asg_configs = {
    name                      = "test-autoscaling-group"
    create_asg                = true
    create_schedule           = false
    force_delete              = true
    min_size                  = 0
    max_size                  = 3
    desired_capacity          = 2
    wait_for_capacity_timeout = 0

    target_group_arns     = []
    wait_for_elb_capacity = 0

    vpc_zone_identifier       = var.vpc_private_subnet_ids
    health_check_type         = "ELB"
    health_check_grace_period = 60
    enabled_metrics           = ["GroupDesiredCapacity", "GroupInServiceCapacity", "GroupMinSize", "GroupMaxSize", "GroupInServiceInstances", "GroupTotalInstances"]

    termination_policies = ["OldestLaunchTemplate"]

    initial_lifecycle_hooks = [
      {
        name                  = "ExampleStartupLifeCycleHook"
        default_result        = "CONTINUE"
        heartbeat_timeout     = 60
        lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
        notification_metadata = jsonencode({ "hello" = "world" })
      },
      {
        name                  = "ExampleTerminationLifeCycleHook"
        default_result        = "CONTINUE"
        heartbeat_timeout     = 180
        lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
        notification_metadata = jsonencode({ "goodbye" = "world" })
      }
    ]
  }

  launch_template_configs = {
    create_lt              = true
    use_lt                 = true
    lt_name                = "test-autoscaling-group-launch-template"
    description            = "Test autoscaling group launch template."
    lt_version             = "$Latest"
    update_default_version = true

    image_id                  = "ami-01cc34ab2709337aa" # Amazon Linux 2 AMI (HVM), SSD Volume Type
    instance_type             = "t2.micro"
    iam_instance_profile_name = aws_iam_instance_profile.ec2_default_profile.id
    ebs_optimized             = false
    enable_monitoring         = true
    block_device_mappings = [
      {
        # Root Volume:
        device_name = "/dev/xvda"
        no_device   = 0
        ebs = {
          delete_on_termination = true
          encrypted             = true
          volume_size           = 20
          volume_type           = "gp2"
        }
      }
    ]
    credit_specification = {
      cpu_credits = "standard"
    }
    instance_market_options = {
      market_type = "spot"
      spot_options = {
        block_duration_minutes         = null
        instance_interruption_behavior = "stop"
        max_price                      = 0.045
        spot_instance_type             = "persistent"
        valid_until                    = null
      }
    }
    network_interfaces = [
      {
        delete_on_termination = true
        description           = "eth0"
        device_index          = 0
        security_groups       = [aws_security_group.asg_instance_sg.id]
      }
    ]
    metadata_options = {
      http_endpoint               = "enabled"
      http_tokens                 = "required"
      http_put_response_hop_limit = 32
    }
    user_data_base64 = null

    # NOTE: Capacity reserveration unused
    capacity_reservation_specification = {
      capacity_reservation_preference = "open"
    }
    # NOTE: Placement unused.
    placement = {
      availability_zone = "us-east-1a"
    }
    placement_group = ""
    # NOTE: CPU options unused. Not supported by "t2.micro".
    cpu_options = {
      core_count       = 1
      threads_per_core = 1
    }
  }
}
