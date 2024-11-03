module "seoul" {
  source = "../modules/vpc/"

  region = "ap-northeast-2"
  cidr_block = "10.0.0.0/16"
  vpc_network_prefix = "10.0"
}
