resource "aws_lb" "test-alb" {
    name = "test-alb-tf"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb-sg.id] 
    subnets  =  [for subnet in aws_subnet.public-subnet : subnet.id]
    tags = {
      Name = "my-test-alb-tf"
    }
}

resource "aws_lb_target_group" "alb-tg" {
    name     = "alb-tg-tf"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "alb-tg-attach" {
    count            = length(aws_instance.web-server)
    target_group_arn = aws_lb_target_group.alb-tg.arn
    target_id        = aws_instance.web-server[count.index].id
    port             = 80
}

resource "aws_lb_listener" "alb-rule" {
    load_balancer_arn = aws_lb.test-alb.arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.alb-tg.arn
    }
}



