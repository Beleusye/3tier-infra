output "vpc_id" {
  value = aws_vpc.infra_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.infra_public_subnet[*].id
}

output "private_subnet_id" {
  value = aws_subnet.infra_private_subnet[*].id
}