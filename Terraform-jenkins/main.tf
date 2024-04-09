# code convention used : resources are named in CAPITAL. variable are starting with Capital.

module "network" {
  source             = "./network"
  Vpc_cidr           = var.Vpc_cidr
  Public_subnet_cidr = var.Public_subnet_cidr
  Availability_zone  = var.Availability_zone
}
module "securityGroup" {
  source      = "./securityGroup"
  Main_vpc_id = module.network.Main_vpc_id
}
module "jenkins" {
  source                    = "./jenkins"
  Tag_name                  = var.Tag_name
  Sg                        = module.securityGroup.Sg
  Sg_ssh                    = module.securityGroup.Sg_ssh
  Ami_id                    = module.ami.Ami_id
  Instance                  = var.Instance
  Subnet_id                 = module.network.Subnet_id
  Security_group            = [module.securityGroup.Sg, module.securityGroup.Sg_ssh]
  Public_ip_boolean         = var.Public_ip_boolean
  User_data_install_jenkins = file("./jenkins_runner_script/jenkins_installer.sh")
}
module "targetGroup" {
  source     = "./targetGroup"
  Name       = var.Name
  Port       = var.Port
  Protocol   = var.Protocol
  Vpc_id     = module.network.Main_vpc_id
  InstanceId = module.jenkins.Jenkins_instance_id
}
module "loadBalancer" {
  source              = "./loadBalancer"
  ALB_arn             = module.loadBalancer.ALB_arn
  Lb_name             = "app-lb"
  Is_external         = false
  Lb_type             = "application"
  Subnet_ids          = tolist(module.network.Subnet_ids)
  Sg_enable_ssh_https = [module.securityGroup.Sg, module.securityGroup.Sg_ssh]
  #targetgroup attachment
  Lb_target_group_arn = module.targetGroup.targetGroupArn
  #listners
  Lb_listner_port                 = 80
  Lb_listner_protocol             = "HTTP"
  Lb_listner_default_action       = "forward"
  Ec2_instance_id                 = module.jenkins.Jenkins_instance_id
  Lb_target_group_attachment_port = 80
}
module "ami" {
  source = "./ami"
}
