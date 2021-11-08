locals {
  tags = {
    Terraform   = "true"
    Environment = var.env
    Application = var.project_name
  }

  asg_configs = {
    name                      = "test-autoscaling-group"
    min_size                  = 0
    max_size                  = 2
    desired_capacity          = 1
    wait_for_capacity_timeout = 0
    health_check_type         = "EC2"
    vpc_zone_identifier       = var.vpc_private_subnet_ids

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
    lt_name                = "test-autoscaling-group-launch-template"
    description            = "Test autoscaling group launch template."
    update_default_version = true

    use_lt    = true
    create_lt = true

    image_id          = "ami-01cc34ab2709337aa" # Amazon Linux 2 AMI (HVM), SSD Volume Type
    instance_type     = "t2.micro"
    ebs_optimized     = true
    enable_monitoring = true

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

    capacity_reservation_specification = {
      capacity_reservation_preference = "open"
    }

    cpu_options = {
      core_count       = 1
      threads_per_core = 1
    }

    credit_specification = {
      cpu_credits = "standard"
    }

    instance_market_options = {
      market_type = "spot"
      spot_options = {
        block_duration_minutes = 60
      }
    }

    metadata_options = {
      http_endpoint               = "enabled"
      http_tokens                 = "required"
      http_put_response_hop_limit = 32
    }

    network_interfaces = [
      {
        delete_on_termination = true
        description           = "eth0"
        device_index          = 0
        security_groups       = [var.vpc_default_sg_name]
      }
    ]

    placement = {
      availability_zone = "us-east-1a"
    }
  }
}