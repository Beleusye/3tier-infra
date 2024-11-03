resource "aws_instance" "infra_ec2_bastion" {
  availability_zone = var.availability_zone
  ami = var.ami_id
  instance_type = var.web_instance_type
  key_name = "infra_key"
  security_groups = [data.terraform_remote_state.security_group.outputs.bastion_sg_id]
  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_id[0]
  user_data = var.bastion_user_data

  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "infra_ec2_web" {
  availability_zone = var.availability_zone
  ami = var.ami_id
  instance_type = var.web_instance_type
  key_name = "infra_key"
  security_groups = [data.terraform_remote_state.security_group.outputs.web_sg_id]
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_id[0]
  user_data = var.web_user_data

  tags = {
    Name = "web"
  }
}

resource "aws_instance" "infra_ec2_was" {
  availability_zone = var.availability_zone
  ami = var.ami_id
  instance_type = var.was_instance_type
  key_name = "infra_key"
  security_groups = [data.terraform_remote_state.security_group.outputs.was_sg_id]
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_id[2]
  user_data = var.was_user_data

  tags = {
    Name = "was"
  }
}

resource "aws_instance" "infra_ec2_db" {
  availability_zone = var.availability_zone
  ami = var.ami_id
  instance_type = var.web_instance_type
  key_name = "infra_key"
  security_groups = [data.terraform_remote_state.security_group.outputs.rds_sg_id]
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_id[2]

  tags = {
    Name = "db"
  }
}