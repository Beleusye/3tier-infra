output "nlb_dns_name" {
    value = module.seoul_lb.nlb_dns_name
}

output "alb_target_group_arn"{
    value = module.seoul_lb.alb_target_group_arn
}

output "nlb_target_group_arn"{
    value = module.seoul_lb.nlb_target_group_arn
}