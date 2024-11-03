output "bastion_sg_id" {
    value = aws_security_group.infra_security_group_bastion.id
}

output "alb_sg_id" {
    value = aws_security_group.infra_security_group_alb.id
}

output "web_sg_id" {
    value = aws_security_group.infra_security_group_web.id
}

output "nlb_sg_id" {
    value = aws_security_group.infra_security_group_nlb.id
}

output "was_sg_id" {
    value = aws_security_group.infra_security_group_was.id
}

output "rds_sg_id" {
    value = aws_security_group.infra_security_group_rds.id
}