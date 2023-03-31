# Create an Elastic IP
resource "aws_eip" "wp_eip" {
  vpc      = true
  tags = {
    name = "wp_eip"
  }
}

resource "aws_nat_gateway" "wpNAT" {
  allocation_id = aws_eip.wp_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "wpNAT_gateway"
  }
}

resource "aws_route_table" "wpNAT_gateway" {
  vpc_id = aws_vpc.wp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.wpNAT.id
  }

 

  tags = {
    Name = "wpNAT_gateway"
  }
}
#associate NAT Gateway to private subnets
resource "aws_route_table_association" "wpNAT_gateway" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "nat_gateway_2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id =aws_route_table.private.id
}
