resource "aws_vpc" "FP_VPC" {
    cidr_block = var.vpc-cidr-block
}

data "aws_availability_zones" "available" {
    state = "available"
}

resource "aws_subnet" "public_subnet" {
    cidr_block = var.public-subnet-cidr-block
    availability_zone = data.aws_availability_zones.available.names[0]
    vpc_id = aws_vpc.FP_VPC.id
}

resource "aws_subnet" "private_subnet" {
    cidr_block = var.private-subnet-cidr-block
    availability_zone = data.aws_availability_zones.available.names[0]
    vpc_id = aws_vpc.FP_VPC.id
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.FP_VPC.id

  tags = {
    Name = "VPC Internet Gateway"
  }
}

resource "aws_route_table" "vpc_rt" {
  vpc_id = aws_vpc.FP_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }
  tags = {
    Name = "Route Table for VPC"
  }
}

resource "aws_route_table_association" "public_subnet_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.vpc_rt.id
}

resource "aws_route_table_association" "private_subnet_rta" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.vpc_rt.id
}