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
  default = "10.0.0.1"
}

variable "ssh_cidr_blocks" {
  type = list(string)
  default = ["0.1.0.2"]
}

variable "vpc_id" {
  type = string
  default = "tst"
}

variable "subnet_id" {
  type = string
  default = "test"
}

variable "key_name" {
  type = string
  default = "test"
}

variable "public_subnet_cidr_block" {
  type = string
  default = "0.1.0.22"
}

variable "private_subnet_cidr_blocks" {
  type = list(string)
  default = ["0.1.0.22"]
}
