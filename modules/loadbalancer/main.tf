resource "aws_lb" "infra_loadbalancer_alb" {
    name = "infra-loadbalancer-alb"
    load_balancer_type = "application"
    security_groups = [data.terraform_remote_state.security_group.outputs.alb_sg_id]
    subnets = data.terraform_remote_state.vpc.outputs.public_subnet_id
   
    tags = {
        Name = "infra-alb"
    }  
}

resource "aws_lb_target_group" "alb_target_group" {
    name = "alb-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

    health_check {
        path = var.health_path
    }

    tags = {
        Name = "alb-tg"
    }
}

resource "aws_lb_target_group_attachment" "alb_tg_attach" {
    target_group_arn = aws_lb_target_group.alb_target_group.arn
    target_id = data.terraform_remote_state.instance.outputs.web_id
    port = 80
}

resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.infra_loadbalancer_alb.arn
    port = "80"
    protocol = "HTTP"
    
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.alb_target_group.arn
    }
}

resource "aws_lb" "infra_loadbalancer_nlb" {
    name = "infra-loadbalancer-nlb"
    load_balancer_type = "network"
    internal = true
    subnets = [data.terraform_remote_state.vpc.outputs.private_subnet_id[0], data.terraform_remote_state.vpc.outputs.private_subnet_id[1]]
}

resource "aws_lb_target_group" "nlb_target_group" {
    name = "nlb-target-group"
    port = 8080
    protocol = "TCP"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

    health_check {
        path = var.health_path
    }

    tags = {
        Name = "alb-tg"
    }
}

resource "aws_lb_target_group_attachment" "nlb_tg_attach" {
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
    target_id = data.terraform_remote_state.instance.outputs.was_id
    port = 8080
}

resource "aws_lb_listener" "nlb_listener" {
    load_balancer_arn = aws_lb.infra_loadbalancer_nlb.arn
    port = "8080"
    protocol = "TCP"
    
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.nlb_target_group.arn
    }
}