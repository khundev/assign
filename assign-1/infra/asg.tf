resource "aws_autoscaling_group" "agents" {
    name = "fleet-A"
    max_size = "1"
    min_size = "1"
    health_check_grace_period = 300
    health_check_type = "EC2"
    desired_capacity = 1
    force_delete = true
    launch_configuration = aws_launch_configuration.lc.name
    target_group_arns = [aws_lb_target_group.alb-tg.arn]
    vpc_zone_identifier  = [aws_subnet.private.id]

    tag {
        key = "Name"
        value = "Agent Instance"
        propagate_at_launch = true
    }
}

resource "aws_launch_configuration" "lc" {
    name_prefix = "lc-"
    image_id = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    security_groups = [aws_security_group.fleet.id]
    iam_instance_profile = aws_iam_instance_profile.some_profile.name
    user_data = file("install-nginx.sh")

    lifecycle {
        create_before_destroy = true
    }

    root_block_device {
        volume_type = "gp2"
        volume_size = "8"
    }
}
