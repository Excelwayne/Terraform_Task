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
    Name = "wpNat_gateway"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
subnet_id = aws_subnet.private_subnet.id 
route_table_id = aws_route_table.wpNAT_gateway.id 
}