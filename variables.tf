variable "ec2_name" {
  type    = string
  default = "bastion_host"
}

variable "ec2_type" {
  type    = string
  default = "t2.micro"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "ssh_cidr_blocks" {
  type = list(string)
  default = ["10.0.0.0/16"]
}

variable "vpc_id" {
  type = string
  default = "terraform-test"
}

variable "subnet_id" {
  type = string
  default = "terraform-subnet"
}

variable "key_name" {
  type = string
  default = "terraform-test-key"
}

variable "public_subnet_cidr_block" {
  type = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr_blocks" {
  type = list(string)
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}
