output "public_id" {
  value = try(aws_instance.this.public_ip, "")
}