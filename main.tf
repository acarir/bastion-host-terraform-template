module "vpc" {
    source = "./modules/vpc"
    vpc_name = "prod"
    vpc_cidr = var.vpc_cidr
    public_subnet_cidr_block  = var.public_subnet_cidr_block
    private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
}

module "keypair" {
  source                = "./modules/keypair"
  key_name              = "bastion-keypair"
  create_private_key    = true
  private_key_algorithm = "RSA"
  private_key_rsa_bits  = 4096
}

module "bastion" {
  source          = "./modules/ec2"
  name            = var.ec2_name
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnet_id
  ec2_type        = var.ec2_type
  key_name        = module.keypair.key_pair_name
  ssh_cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
}