resource "aws_instance" "web-server" {
    count = 3
    ami = var.ec2-ami
    instance_type = var.ec2-type    
    subnet_id = aws_subnet.public-subnet[count.index % 2].id
    key_name = "learning"
    security_groups = [ aws_security_group.web-sg.id ]
    associate_public_ip_address = true
    tags = {
      Name =  var.ec2-name[count.index]
    }
    user_data = <<-EOF
                #!/bin/bash
                apt-get update -y
                apt-get upgrade -y
                Install Apache HTTP Server
                apt-get install -y apache2
                systemctl start apache2
                systemctl enable apache2
                PRIVATE_IP=$(hostname -I | awk '{print $1}')
                echo "<html>
                    <head><title>Apache Web Server</title></head>
                     <body>
                        <h1>Hello World!</h1>
                        <p>EC2 Instance Private IP Address: $PRIVATE_IP</p>
                      </body>
                    </html>" > /var/www/html/index.html
                    systemctl restart apache2
                EOF    
}  

