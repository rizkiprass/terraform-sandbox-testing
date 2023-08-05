module "ec2-openvpn" {
  source = "rizkiprass/ec2-openvpn-as/aws"

  name          = "Openvpn Access Server"
  create_ami    = true
  instance_type = "t3.micro"
  key_name      = ""
  vpc_id        = aws_vpc.vpc.id
  ec2_subnet_id = aws_subnet.public-subnet-3a.id
  user_openvpn  = "user-1"
  routing_ip    = "30.0.0.0/16"

  tags = merge(local.common_tags, {
    OS = "Ubuntu",
  })
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = merge(local.common_tags,
    {
      Name = format("%s-%s-VPC", var.project, var.environment)
  })
}

//Public Subnet
resource "aws_subnet" "public-subnet-3a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.Public_Subnet_AZA_1
  availability_zone = format("%sa", var.region)

  tags = merge(local.common_tags,
    {
      Name = format("%s-%s-public-subnet-3a", var.project, var.environment) //
  })
}

resource "aws_subnet" "public-subnet-3b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.Public_Subnet_AZB_2
  availability_zone = format("%sb", var.region)

  tags = merge(local.common_tags, {
    Name = format("%s-%s-public-subnet-3b", var.project, var.environment)
  })
}

//IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tags, {
    Name = format("%s-%s-igw", var.project, var.environment)
  })
}

//EIP (Elastic IP)
resource "aws_eip" "eip" {
  vpc = true

  tags = merge(local.common_tags, {
    Name = format("%s-%s-eip", var.project, var.environment)
  })
}


//NAT Gateway
resource "aws_nat_gateway" "natgw-3a" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet-3a.id
  depends_on = [
  aws_internet_gateway.igw]

  tags = merge(local.common_tags, {
    Name = format("%s-%s-nat-3a", var.project, var.environment)
  })
}

//routing table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name = format("%s-%s-public-rt", var.project, var.environment)
  })
}


//routing table association
resource "aws_route_table_association" "rt-subnet-assoc-public-3a" {
  subnet_id      = aws_subnet.public-subnet-3a.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "rt-subnet-assoc-public-3b" {
  subnet_id      = aws_subnet.public-subnet-3b.id
  route_table_id = aws_route_table.public-rt.id
}