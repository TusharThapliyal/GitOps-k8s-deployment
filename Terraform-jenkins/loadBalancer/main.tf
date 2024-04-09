resource "aws_alb" "APPLICATION_LOAD_BALANCER" {
  name               = var.Lb_name
  internal           = var.Is_external
  load_balancer_type = var.Lb_type
  security_groups    = var.Sg_enable_ssh_https
  subnets            = var.Subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "app-lb"
  }
}
resource "aws_lb_target_group_attachment" "APB_TARGET_GROUP_ATTACHMENT" {
  target_group_arn = var.Lb_target_group_arn
  target_id        = var.Ec2_instance_id # Replace with your EC2 instance reference
  port             = var.Lb_target_group_attachment_port

}

resource "aws_lb_listener" "ALB_HTTP_Listner" {
  load_balancer_arn = var.ALB_arn
  port              = var.Lb_listner_port
  protocol          = var.Lb_listner_protocol

  default_action {
    type             = var.Lb_listner_default_action
    target_group_arn = var.Lb_target_group_arn
  }
}
