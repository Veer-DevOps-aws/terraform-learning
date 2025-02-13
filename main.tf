resource "aws_vpc" "main" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = var.vpc-name
  }
}

resource "aws_subnet" "public-subnet" {
    count = 3
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet-cidr[count.index]
    availability_zone = var.subnet-amz[count.index]
    tags = {
      Name: "pub-sub-${count.index + 1}"
    }
}

resource "aws_subnet" "private-subnet" {
  count = 3
  vpc_id = aws_vpc.main.id
  cidr_block = var.priv-sub-cidr[count.index]
  availability_zone = var.priv-amz[count.index]
  tags = {
    Name = "priv-sub-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw-name
  }
}

resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.public-route
  }
}

resource "aws_route_table_association" "pub-sub" {
  count = length(aws_subnet.public-subnet)
  subnet_id = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-route.id   
}





