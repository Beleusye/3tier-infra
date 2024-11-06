resource "aws_autoscaling_group" "infra_autoscaling_web" {
    name = "web-autoscaler"
    max_size = var.max_size
    min_size = var.min_size
    health_check_grace_period = 300
    health_check_type = "ELB"
    desired_capacity = var.capacity
    force_delete = true
    
    vpc_zone_identifier = [for i in [0,1] : data.terraform_remote_state.vpc.outputs.private_subnet_ids[i]]
    target_group_arns = [data.terraform_remote_state.loadbalancer.outputs.alb_target_group_arn]

    launch_template {
        id = data.terraform_remote_state.instance.outputs.web_template_id
    }

    instance_maintenance_policy {
        min_healthy_percentage = 90
        max_healthy_percentage = 120
    }
}

resource "aws_autoscaling_group" "infra_autoscaling_was" {
    name = "was-autoscaler"
    max_size = var.max_size
    min_size = var.min_size
    health_check_grace_period = 450
    health_check_type = "ELB"
    desired_capacity = var.capacity
    force_delete = true
    
    vpc_zone_identifier = [for i in [2,3] : data.terraform_remote_state.vpc.outputs.private_subnet_ids[i]]
    target_group_arns = [data.terraform_remote_state.loadbalancer.outputs.nlb_target_group_arn]

    launch_template {
        id = data.terraform_remote_state.instance.outputs.was_template_id
    }

    instance_maintenance_policy {
        min_healthy_percentage = 90
        max_healthy_percentage = 120
    }
}