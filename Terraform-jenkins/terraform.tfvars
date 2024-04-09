#used in network module
Region             = "us-east-1"
Vpc_cidr           = "10.0.0.0/16"
Public_subnet_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
Availability_zone  = ["us-east-1a", "us-east-1b"]

#used in jenkins module
Instance          = "t3.small"
Public_ip_boolean = true
Tag_name          = "Jenkins_server"
Name              = "main-tg"
Port              = 8080
Protocol          = "HTTP"
