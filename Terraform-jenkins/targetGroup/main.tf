resource "aws_lb_target_group" "MAIN_TG" {
  name     = var.Name
  port     = var.Port
  protocol = var.Protocol
  vpc_id   = var.Vpc_id
  health_check {
    path                = "/login"
    port                = 8080
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = 200 #if not 200 then fail.
  }
}
resource "aws_lb_target_group_attachment" "TARGET_GROUP_ATTACHMENT" {
  target_group_arn = aws_lb_target_group.MAIN_TG.arn
  target_id        = var.InstanceId
  port             = 8080
}
