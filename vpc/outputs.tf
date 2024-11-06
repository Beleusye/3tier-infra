output "vpc_id" {
  value = module.seoul.vpc_id
}

output "public_subnet_ids" {
  value = module.seoul.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.seoul.private_subnet_ids
}
