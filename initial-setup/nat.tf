resource "aws_eip" "magento-nat" {
  vpc = true
  tags = {
    Name = "magento-nat-eip"
  }
}

resource "aws_nat_gateway" "magento-nat-gw" {
  allocation_id = aws_eip.magento-nat.id
  subnet_id     = aws_subnet.magento-public-1.id
  depends_on    = [aws_internet_gateway.magento-gw]
  tags = {
    Name = "magento-nat"
  }
}

resource "aws_route_table" "magento-private" {
  vpc_id = aws_vpc.magento.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.magento-nat-gw.id
  }

  tags = {
    Name = "magento-private-1"
  }
}

resource "aws_route_table_association" "magento-private-1-a" {
  subnet_id      = aws_subnet.magento-private-1.id
  route_table_id = aws_route_table.magento-private.id
}

resource "aws_route_table_association" "magento-private-2-a" {
  subnet_id      = aws_subnet.magento-private-2.id
  route_table_id = aws_route_table.magento-private.id
}

resource "aws_route_table_association" "magento-private-3-a" {
  subnet_id      = aws_subnet.magento-private-3.id
  route_table_id = aws_route_table.magento-private.id
}

