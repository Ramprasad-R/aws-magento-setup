resource "aws_vpc" "magento" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "magento-vpc"
  }
}

resource "aws_subnet" "magento-public-1" {
  vpc_id                  = aws_vpc.magento.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "magento-public-1"

  }
}

resource "aws_subnet" "magento-public-2" {
  vpc_id                  = aws_vpc.magento.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    Name = "magento-public-2"

  }
}

resource "aws_subnet" "magento-public-3" {
  vpc_id                  = aws_vpc.magento.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
    Name = "magento-public-3"

  }
}

resource "aws_subnet" "magento-private-1" {
  vpc_id                  = aws_vpc.magento.id
  cidr_block              = "10.0.11.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "magento-private-1"
  }
}

resource "aws_subnet" "magento-private-2" {
  vpc_id                  = aws_vpc.magento.id
  cidr_block              = "10.0.12.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    Name = "magento-private-2"
  }
}

resource "aws_subnet" "magento-private-3" {
  vpc_id                  = aws_vpc.magento.id
  cidr_block              = "10.0.13.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
    Name = "magento-private-3"
  }
}


resource "aws_internet_gateway" "magento-gw" {
  vpc_id = aws_vpc.magento.id

  tags = {
    Name = "magento-igw"
  }
}


resource "aws_route_table" "magento-public" {
  vpc_id = aws_vpc.magento.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.magento-gw.id
  }

  tags = {
    Name = "magento-public-1"
  }
}


resource "aws_route_table_association" "magento-public-1-a" {
  subnet_id      = aws_subnet.magento-public-1.id
  route_table_id = aws_route_table.magento-public.id
}

resource "aws_route_table_association" "magento-public-2-a" {
  subnet_id      = aws_subnet.magento-public-2.id
  route_table_id = aws_route_table.magento-public.id
}

resource "aws_route_table_association" "magento-public-3-a" {
  subnet_id      = aws_subnet.magento-public-3.id
  route_table_id = aws_route_table.magento-public.id
}
