module "seoul_instance" {
  source = "../modules/instance"

  region = "ap-northeast-2"
  availability_zone = "ap-northeast-2a"
  ami_id = "ami-02c329a4b4aba6a48" # Amazon Linux 2023 AMI
  web_instance_type = "t2.micro"
  was_instance_type = "t2.medium"
  
  bastion_user_data = local.bastion_user_data
  web_user_data = local.web_user_data
  was_user_data = local.was_user_data
}