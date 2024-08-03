provider "aws" {
  region = "eu-north-1"
}

# Write
# Terraform Init
# Terraform Plan
# Terraform Apply
# Terraform Destroy


# VPC
resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"
  
  tags = {
    Name = "main-tf-vpc"
  }
}

# Subnet 1
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "eu-north-1a"
  
  tags = {
    Name = "Subnet-1"
  }
}

# Subnet 2
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "eu-north-1b"
  
  tags = {
    Name = "Subnet-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-vpc-igw"
  }
}

# Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "main-public-route-table"
  }
}

# Route Table Association for Subnet 1
resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

# Route Table Association for Subnet 2
resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table.id
}
