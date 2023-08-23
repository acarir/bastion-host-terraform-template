resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = var.create_private_key ? trimspace(tls_private_key.this[0].public_key_openssh) : var.public_key

  tags = {
    Name = var.key_name
  }
}

resource "tls_private_key" "this" {
  count = var.create_private_key ? 1 : 0

  algorithm = var.private_key_algorithm
  rsa_bits  = var.private_key_rsa_bits
}

resource "local_file" "tf-key" {
  count    = var.create_private_key ? 1 : 0
  content  = tls_private_key.this[0].private_key_pem
  filename = "${path.cwd}/${var.key_name}-key-pair"
}