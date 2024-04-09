#jenkins server
resource "aws_instance" "JENKINS_SERVER" {
  tags = {
    Name = var.Tag_name
  }
  key_name                    = "jenkins_demo"
  ami                         = var.Ami_id
  instance_type               = var.Instance
  subnet_id                   = var.Subnet_id
  associate_public_ip_address = var.Public_ip_boolean
  vpc_security_group_ids      = var.Security_group
  user_data                   = var.User_data_install_jenkins

  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}
resource "aws_key_pair" "name" {
  public_key = file("~/.ssh/jenkins_demo.pub")
  key_name   = "jenkins_demo"
}
