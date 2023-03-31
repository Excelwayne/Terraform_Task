# Create an internet gateway and attach it to the VPC

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.wp_vpc.id

  tags = {
    Name = "internet-gateway"
  }
}

# Create a route table and associate it with the VPC
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.wp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate the public subnets with the route table

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_subnet1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public.id
}


# Create a route table for the private subnets

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.wp_vpc.id
  route { 
    gateway_id = aws_nat_gateway.wpNAT.id
    cidr_block = "0.0.0.0/0"

  }

  tags = {
    Name = "private-route-table"
  }
}

# Associate the private subnet with the private route table
resource "aws_route_table_association" "private_subnet" {
  subnet_id     = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}


resource "aws_route_table_association" "private_subnet2" {
  subnet_id     = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private.id
}
