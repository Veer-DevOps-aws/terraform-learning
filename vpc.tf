resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    
    tags = {
        Name = "Demo-vpc"
    }
  
}
resource "aws_subnet" "main_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "Demo-pub-sub-1"
    }
  
}

resource "aws_subnet" "main_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name = "Demo-pub-sub-2"
    }
  
}

resource "aws_subnet" "main_3" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "ap-south-1c"
    tags = {
      Name = "Demo-pub-sub-2"
    }
  
}

resource "aws_subnet" "private_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "Demo-priv-sub-1"
    }
  
}

resource "aws_subnet" "private_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name = "Demo-priv-sub-2"
    }
  
}

resource "aws_subnet" "private_3" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.6.0/24"
    availability_zone = "ap-south-1c"
    tags = {
      Name = "Demo-priv-sub-2"
    }
  
}

resource "aws_internet_gateway" "demoigw" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "Demo_igw"
    }
  
}

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demoigw.id
  }

  tags = {
    Name = "my-public-route-table"  
  }
}

resource "aws_route_table_association" "pub_sub_1" {
    subnet_id = aws_subnet.main_1.id
    route_table_id = aws_route_table.publicrt.id
  
}

resource "aws_route_table_association" "pub_sub_2" {
    subnet_id = aws_subnet.main_2.id
    route_table_id = aws_route_table.publicrt.id
  
}
resource "aws_route_table_association" "pub_sub_3" {
    subnet_id = aws_subnet.main_3.id
    route_table_id = aws_route_table.publicrt.id
  
}