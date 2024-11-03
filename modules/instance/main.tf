resource "aws_instance" "infra_ec2_bastion" {
  ami = var.ami_id
  instance_type = var.web_instance_type
  key_name = "infra_key"
  security_groups = [data.terraform_remote_state.security_group.outputs.bastion_sg_id]
  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  user_data = var.bastion_user_data

  tags = {
    Name = "bastion"
  }
}

/*resource "aws_instance" "infra_ec2_web" {
  availability_zone = var.availability_zone
  ami = var.ami_id
  instance_type = var.web_instance_type
  key_name = "infra_key"
  security_groups = [data.terraform_remote_state.security_group.outputs.web_sg_id]
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_ids[0]
  user_data = var.web_user_data

  tags = {
    Name = "web"
  }
}*/

/*resource "aws_instance" "infra_ec2_was" {
  availability_zone = var.availability_zone
  ami = var.ami_id
  instance_type = var.was_instance_type
  key_name = "infra_key"
  security_groups = [data.terraform_remote_state.security_group.outputs.was_sg_id]
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_ids[2]
  user_data = var.was_user_data

  tags = {
    Name = "was"
  }
}*/

resource "aws_launch_template" "template_web" {
  name = "lt-web"

  image_id = var.ami_id # Amazon Linux 2023
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.web_instance_type # t2.micro
  key_name = "infra_key"
  user_data = base64encode(var.web_user_data)

  vpc_security_group_ids = [data.terraform_remote_state.security_group.outputs.web_sg_id]
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "web-instance"
    }
  }

  tags = {
    Name = "web-lt"
  }
}

resource "aws_launch_template" "template_was" {
  name = "lt-was"

  image_id = var.ami_id # Amazon Linux 2023
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.was_instance_type # t2.medium
  key_name = "infra_key"
  user_data = base64encode(var.was_user_data)

  vpc_security_group_ids = [data.terraform_remote_state.security_group.outputs.was_sg_id]
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "was-instance"
    }
  }

  tags = {
    Name = "was-lt"
  }
}