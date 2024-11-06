output "nlb_dns_name" {
    value = aws_lb.infra_loadbalancer_nlb.dns_name
}

output "alb_target_group_arn"{
    value = aws_lb_target_group.alb_target_group.arn
}

output "nlb_target_group_arn"{
    value = aws_lb_target_group.nlb_target_group.arn
}