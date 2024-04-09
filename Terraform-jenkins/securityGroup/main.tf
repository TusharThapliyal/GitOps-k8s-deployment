# security group for jenkins server
resource "aws_security_group" "SG"{
    name = "MY_SG"
    description = "allows ssh and custom TCP rule"
    vpc_id = var.Main_vpc_id

    ingress {
        description = "allows https"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        description = "allows http"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        description = "allows custom tcp on port 8080"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        description = "outbount anywhere"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

# SG allowing ssh
resource "aws_security_group" "SG_SSH"{
    name = "SG_SSH"
    description = "allows ssh into instance"
    vpc_id = var.Main_vpc_id
    ingress {
        description = "allows ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
} 