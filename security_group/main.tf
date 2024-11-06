resource "aws_security_group" "infra_security_group_bastion" {
    name = "bastion_security_group"
    description = "Bastion Security Group"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

    tags = {
        Name = "infra-bastion-security-group"
    }
}

resource "aws_security_group_rule" "bastion_ssh_rule" {
    security_group_id = aws_security_group.infra_security_group_bastion.id
    description = "SSH"
    
    from_port = 2200
    to_port = 2200
    protocol = "tcp"
    type = "ingress"
    cidr_blocks = ["${var.my_ip}/32"]
}

resource "aws_security_group_rule" "bastion_egress_rule" {
    security_group_id = aws_security_group.infra_security_group_bastion.id
    description = "ALL"
    
    from_port = 0
    to_port = 0
    protocol = "-1"
    type = "egress"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "infra_security_group_alb" {
    name = "alb_security_group"
    description = "Application LoadBalancer Security Group"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

    tags = {
        Name = "infra-alb-security-group"
    }
}

resource "aws_security_group_rule" "alb_http_ingress" {
    security_group_id = aws_security_group.infra_security_group_alb.id
    description = "HTTP"
    
    from_port = 80
    to_port = 80
    protocol = "tcp"
    type = "ingress"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_https_ingress" {
    security_group_id = aws_security_group.infra_security_group_alb.id
    description = "HTTP"
    
    from_port = 443
    to_port = 443
    protocol = "tcp"
    type = "ingress"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_http_egress" {
    security_group_id = aws_security_group.infra_security_group_alb.id
    description = "ALL"
    
    from_port = 80
    to_port = 80
    protocol = "tcp"
    type = "egress"
    source_security_group_id = aws_security_group.infra_security_group_web.id
}

resource "aws_security_group_rule" "alb_https_egress" {
    security_group_id = aws_security_group.infra_security_group_alb.id
    description = "ALL"
    
    from_port = 443
    to_port = 443
    protocol = "tcp"
    type = "egress"
    source_security_group_id = aws_security_group.infra_security_group_web.id
}

resource "aws_security_group" "infra_security_group_web" {
    name = "web_security_group"
    description = "WebServer Security Group"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

    tags = {
        Name = "infra-web-security-group"
    }
}

resource "aws_security_group_rule" "web_ssh_ingress" {
    security_group_id = aws_security_group.infra_security_group_web.id
    description = "SSH"
    
    from_port = 22
    to_port = 22
    protocol = "tcp"
    type = "ingress"

    source_security_group_id = aws_security_group.infra_security_group_bastion.id
}

resource "aws_security_group_rule" "web_http_ingress" {
    security_group_id = aws_security_group.infra_security_group_web.id
    description = "HTTP"
    
    from_port = 80
    to_port = 80
    protocol = "tcp"
    type = "ingress"
    source_security_group_id = aws_security_group.infra_security_group_alb.id
}

resource "aws_security_group_rule" "web_all_egress" {
    security_group_id = aws_security_group.infra_security_group_web.id
    description = "ALL"
    
    from_port = 0
    to_port = 0
    protocol = "-1"
    type = "egress"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "infra_security_group_nlb" {
    name = "nlb_security_group"
    description = "Network LoadBalancer Security Group"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

    tags = {
        Name = "infra-nlb-security-group"
    }
}

resource "aws_security_group_rule" "nlb_was_ingress" {
    security_group_id = aws_security_group.infra_security_group_nlb.id
    description = "tomcat"
    
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    type = "ingress"
    source_security_group_id = aws_security_group.infra_security_group_web.id
}

resource "aws_security_group_rule" "nlb_was_egress" {
    security_group_id = aws_security_group.infra_security_group_nlb.id
    description = "ALL"
    
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    type = "egress"
    source_security_group_id = aws_security_group.infra_security_group_was.id
}

resource "aws_security_group" "infra_security_group_was" {
    name = "was_security_group"
    description = "WebApplicationServer Security Group"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

    tags = {
        Name = "infra-was-security-group"
    }
}

resource "aws_security_group_rule" "was_ssh_ingress" {
    security_group_id = aws_security_group.infra_security_group_was.id
    description = "SSH"
    
    from_port = 22
    to_port = 22
    protocol = "tcp"
    type = "ingress"

    source_security_group_id = aws_security_group.infra_security_group_bastion.id
}

resource "aws_security_group_rule" "was_was_ingress" {
    security_group_id = aws_security_group.infra_security_group_was.id
    description = "HTTP"
    
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    type = "ingress"

    source_security_group_id = aws_security_group.infra_security_group_nlb.id
}

resource "aws_security_group_rule" "was_all_egress" {
    security_group_id = aws_security_group.infra_security_group_was.id
    description = "ALL"
    
    from_port = 0
    to_port = 0
    protocol = "-1"
    type = "egress"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "infra_security_group_rds" {
    name = "rds_security_group"
    description = "RDS Security Group"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

    tags = {
        Name = "infra-rds-security-group"
    }
}

resource "aws_security_group_rule" "rds_ssh_ingress" {
    security_group_id = aws_security_group.infra_security_group_rds.id
    description = "SSH"
    
    from_port = 22
    to_port = 22
    protocol = "tcp"
    type = "ingress"

    source_security_group_id = aws_security_group.infra_security_group_bastion.id
}

resource "aws_security_group_rule" "rds_mysql_ingress" {
    security_group_id = aws_security_group.infra_security_group_rds.id
    description = "SSH"
    
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    type = "ingress"

    source_security_group_id = aws_security_group.infra_security_group_was.id
}

resource "aws_security_group_rule" "rds_mysql_egress" {
    security_group_id = aws_security_group.infra_security_group_rds.id
    description = "ALL"
    
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    type = "egress"
    source_security_group_id = aws_security_group.infra_security_group_was.id
}