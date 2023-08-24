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
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.vpc_name}-subnet-public"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //RTB uses this IGW to reach internet
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-rtb"
  }
}

resource "aws_route_table_association" "public-subnet" {
  subnet_id      = aws_subnet.subnet-public.id
  route_table_id = aws_route_table.public-rtb.id
}


###### PRIVATE SUBNET #######

resource "aws_subnet" "subnet-private" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.private_subnet_cidr_blocks)
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  tags = {
    Name = "${var.vpc_name}-subnet-private-${count.index}"
  }
}

resource "aws_eip" "natgw_eip" {
  count  = length(var.private_subnet_cidr_blocks)
  domain = "vpc"
  tags = {
    Name = "${var.vpc_name}-eip-${count.index}"
  }
}

resource "aws_nat_gateway" "connection_to_public_subnet" {
  count         = length(var.private_subnet_cidr_blocks)
  allocation_id = element(aws_eip.natgw_eip.*.id, count.index)
  subnet_id     = aws_subnet.subnet-public.id

  tags = {
    Name = "${var.vpc_name}-natgw-${count.index}"
  }
}

resource "aws_route_table" "private-rtb" {
  count  = length(var.private_subnet_cidr_blocks)
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-subnet-private-rtb-${count.index}"
  }
}

# Associate per Private Subnet with its own Private Route Table
resource "aws_route_table_association" "private_subnets_to_private_rtb" {
  count          = length(var.private_subnet_cidr_blocks)
  route_table_id = element(aws_route_table.private-rtb.*.id, count.index)
  subnet_id      = element(aws_subnet.subnet-private.*.id, count.index)
  depends_on     = [aws_route_table.private-rtb, aws_subnet.subnet-private]
}


resource "aws_route" "private_subnet_to_nat_gw" {
  count                  = length(var.private_subnet_cidr_blocks)
  route_table_id         = element(aws_route_table.private-rtb.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.connection_to_public_subnet[count.index].id

  # To ensure proper ordering, explicit dependency on Internet Gateway
  depends_on = [aws_route_table.private-rtb]
}

###### DEFAULT ROUTE TABLE #######

resource "aws_default_route_table" "default_rtb" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = {
    Name = "${var.vpc_name}-subnet-default-rtb"
  }
}