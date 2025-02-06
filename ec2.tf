resource "aws_security_group" "Demo" {
    name = "web_sg"
    description = "allow inbound and outbound for web"
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "Demo_sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow" {
    security_group_id = aws_security_group.Demo.id

    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}

resource "aws_instance" "Demo-web" {
  ami             = "ami-00bb6a80f01f03502"   
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main_1.id
  key_name        = "learning"
  vpc_security_group_ids = [aws_security_group.Demo.id]  
  tags = {
    Name = "Demo-Web-Server"
  }
}

