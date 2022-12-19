resource "aws_lb" "alb" {
  name               = "public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [for subnet in data.aws_subnet.default : subnet.id]

  tags = {
    developed_by = "khun"
  }
}

resource "aws_lb_listener" "listener-tg1" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}

resource "aws_lb_target_group" "alb-tg" {
  name     = "fleet-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.default.id
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}