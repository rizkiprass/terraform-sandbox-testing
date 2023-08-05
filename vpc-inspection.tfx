

//create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = merge(local.common_tags,
    {
      Name = format("%s-%s-VPC", var.customer, var.environment)
  })
}

//Public Subnet
resource "aws_subnet" "public-subnet-3a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.Public_Subnet_AZA
  availability_zone = format("%sa", var.region)

  tags = merge(local.common_tags,
    {
      Name = format("%s-%s-public-subnet-3a", var.customer, var.environment) //
  })
}

resource "aws_subnet" "public-subnet-3b" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.Public_Subnet_AZB
  availability_zone = format("%sb", var.region)

  tags = merge(local.common_tags, {
    Name = format("%s-%s-public-subnet-3b", var.customer, var.environment)
  })
}

//App subnet
resource "aws_subnet" "app-subnet-3a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.App_Subnet_AZA
  availability_zone = format("%sa", var.region)

  tags = merge(local.common_tags, {
    Name = format("%s-%s-public2-subnet-3a", var.customer, var.environment)
  })
}

resource "aws_subnet" "app-subnet-3b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.App_Subnet_AZB
  availability_zone = format("%sb", var.region)

  tags = merge(local.common_tags, {
    Name = format("%s-%s-public2-subnet-3b", var.customer, var.environment)
  })
}

resource "aws_subnet" "data-subnet-3a" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.Data_Subnet_AZA
  availability_zone = format("%sa", var.region)

  tags = merge(local.common_tags,
    {
      Name = format("%s-%s-data-subnet-3a", var.customer, var.environment) //
  })
}

resource "aws_subnet" "data-subnet-3b" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.Data_Subnet_AZB
  availability_zone = format("%sb", var.region)

  tags = merge(local.common_tags, {
    Name = format("%s-%s-data-subnet-3b", var.customer, var.environment)
  })
}

//IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tags, {
    Name = format("%s-%s-igw", var.customer, var.environment)
  })
}

//EIP (Elastic IP)
resource "aws_eip" "eip" {
  vpc = true

  tags = merge(local.common_tags, {
    Name = format("%s-%s-eip", var.customer, var.environment)
  })
}


//NAT Gateway
resource "aws_nat_gateway" "natgw-3a" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet-3a.id
  depends_on = [
  aws_internet_gateway.igw]

  tags = merge(local.common_tags, {
    Name = format("%s-%s-nat-3a", var.customer, var.environment)
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
    Name = format("%s-%s-public-rt", var.customer, var.environment)
  })
}

resource "aws_route_table" "app-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name = format("%s-%s-public2-rt", var.customer, var.environment)
  })
}

resource "aws_route_table" "data-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw-3a.id
  }

  tags = merge(local.common_tags, {
    Name = format("%s-%s-data-rt", var.customer, var.environment)
  })
}


//routing table association
resource "aws_route_table_association" "rt-subnet-assoc-public-3a" {
  subnet_id      = aws_subnet.public-subnet-3a.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "rt-subnet-assoc-app-3a" {
  subnet_id      = aws_subnet.app-subnet-3a.id
  route_table_id = aws_route_table.app-rt.id
}

resource "aws_route_table_association" "rt-subnet-assoc-data-3a" {
  subnet_id      = aws_subnet.data-subnet-3a.id
  route_table_id = aws_route_table.data-rt.id
}

resource "aws_route_table_association" "rt-subnet-assoc-public-3b" {
  subnet_id      = aws_subnet.public-subnet-3b.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "rt-subnet-assoc-app-3b" {
  subnet_id      = aws_subnet.app-subnet-3b.id
  route_table_id = aws_route_table.app-rt.id
}

resource "aws_route_table_association" "rt-subnet-assoc-data-3b" {
  subnet_id      = aws_subnet.data-subnet-3b.id
  route_table_id = aws_route_table.data-rt.id
}