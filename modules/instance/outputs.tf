output "nlb_endpoint" {
    value = data.terraform_remote_state.loadbalancer.outputs.nlb_dns_name
}

output "rds_endpoint" {
    value = data.terraform_remote_state.rds.outputs.rds_endpoint
}
