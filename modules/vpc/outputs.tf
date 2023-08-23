output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.subnet-public.id
}

output "private_subnet_ids" {
  value = aws_subnet.subnet-private[*].id
}
