resource "aws_security_group" "alb-sg" {
    name = "alb-sg"
    vpc_id      = aws_vpc.main.id
    description = "Allow inbound traffic and all outbound traffic"
  
  tags = {
    Name = "alb-sg"
  }

  # Allow inbound HTTP (port 80) from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTPS (port 443) from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic (for any protocol)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic to anywhere
  }
   
}

resource "aws_security_group" "web-sg" {
    name = "webserver-sg"
    vpc_id      = aws_vpc.main.id
    description = "security group for webservers"
  
  tags = {
    Name = "webserver-sg"
  }

  # Allow HTTP (port 80) from ALB security group
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]  # Reference to ALB security group
  }

  # Allow HTTPS (port 443) from your IP (replace with the actual IP variable)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my-ip]  # Replace with your IP or a variable
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

}


