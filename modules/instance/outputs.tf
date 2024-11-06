output "nlb_endpoint" {
    value = data.terraform_remote_state.loadbalancer.outputs.nlb_dns_name
}

output "rds_endpoint" {
    value = data.terraform_remote_state.rds.outputs.rds_endpoint
}

output "web_template_id" {
    value = aws_launch_template.template_web.id
}

output "was_template_id" {
    value = aws_launch_template.template_was.id
}
