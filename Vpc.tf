# Create a VPC
resource "aws_vpc" "wp_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  

  tags = {
    Name = "wp_vpc"
  }
}

# Create two subnets 
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  

  tags = {
    Name = "public_subnet"
  }
}
resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2a"
 

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2b"
 

  tags = {
    Name = "private_subnet2"
  }
}
resource "aws_db_subnet_group" "db_subnet" {
    name =      "db_subnet"
    subnet_ids =  [aws_subnet.private_subnet.id,aws_subnet.private_subnet2.id]

    tags = {
        Name = "db subnet"
    }
}
