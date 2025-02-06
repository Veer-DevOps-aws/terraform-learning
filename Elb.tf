resource "aws_lb" "demo_alb" {
    name = "demo-App"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.Demo.id ]
    subnets = [ aws_subnet.main_1.id, aws_subnet.main_2.id, aws_subnet.main_3.id ]
    tags = {
      environment = "dev"
    }
  
}

resource "aws_lb_target_group" "Demo_tg" {
  name     = "App-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "demo_listener" {
    load_balancer_arn = aws_lb.demo_alb.arn
    port = "80" 
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.Demo_tg.arn
    }
  
}

resource "aws_lb_target_group_attachment" "name" {
    target_group_arn = aws_lb_target_group.Demo_tg.arn
    target_id = aws_instance.Demo-web.id
    port = 80
}