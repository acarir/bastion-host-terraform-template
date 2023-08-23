variable "name" {
  type = string
}

variable "ec2_type" {
  type = string
}

variable "ssh_cidr_blocks" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}