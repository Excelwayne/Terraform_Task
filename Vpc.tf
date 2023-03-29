# Create a VPC
resource "aws_vpc" "wp_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  

  tags = {
    Name = "wp_vpc-vpc"
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

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2a"
 

  tags = {
    Name = "private_subnet"
  }
}


