provider "aws" {
  region  = "us-east-1"
}

# Declare the data source --> aws_availability_zones.available.names --> list 
data "aws_availability_zones" "available" {
  state = "available"
}

variable "vpc_cidr_block" {
  type        = string
  description = "vpc cidr block"
  default     = "10.1.0.0/16"
}

variable "instance_tenancy_type" {
  type        = string
  description = "instance_tenancy_type"
  default     = "default"
}

# VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy_type

  tags = {
    "Name" = "capstone_vpc"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "capstone_igw"
  }
}

# Public_Subnet_1 - us-east-1a
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "capstone_public_subnet_1"
  }
}

# Public_Subnet_2 - us-east-1b
resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "capstone_public_subnet_2"
  }
}

# Private_Subnet_1 - us-east-1a
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "capstone_private_subnet_1"
  }
}

# Private_Subnet_2 - us-east-1b
resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.4.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "capstone_private_subnet_2"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "capstone_public_rt"
  }
}

# Public Route Table - Subnet Associations
resource "aws_route_table_association" "public_rt_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Public Route Table - Subnet Associations for public_subnet_2
resource "aws_route_table_association" "public_rt_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

# Nat Gateway
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.eip.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnet_1.id
  tags = {
    Name = "capstone_nat"
  }
}

# Elastic IP
resource "aws_eip" "eip" {
  vpc = true
  tags = {
    Name = "capstone_eip"
  }
}

# Private Route Table 
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = "capstone_private_rt"
  }
}

# Private Route Table - Subnet Associations for private_subnet_1
resource "aws_route_table_association" "private_rt_assoc_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

# Private Route Table - Subnet Associations for private_subnet_2
resource "aws_route_table_association" "private_rt_assoc_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}
