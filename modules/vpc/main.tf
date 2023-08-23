resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  instance_tenancy     = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet-public" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr_block
    map_public_ip_on_launch = "true"
    availability_zone       = data.aws_availability_zones.available.names[0]
    tags = {
        Name = "${var.vpc_name}-subnet-public"
    }
}

resource "aws_subnet" "subnet-private" {
    vpc_id = aws_vpc.vpc.id
    count = length(var.private_subnet_cidr_blocks)
    cidr_block = var.private_subnet_cidr_blocks[count.index]
    map_public_ip_on_launch = "true"
    availability_zone       = data.aws_availability_zones.available.names[0]
    tags = {
        Name = "${var.vpc_name}-subnet-private-${count.index}"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "public-crt" {
  vpc_id = aws_vpc.vpc.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-crt"
  }
}

resource "aws_route_table_association" "public-subnet" {
  subnet_id      = aws_subnet.subnet-public.id
  route_table_id = aws_route_table.public-crt.id
}