locals {
  openvpn_name = format("%s-%s-openvpn", var.customer, var.environment)
}

module "ovpn_instance" {
  source = "./modules/ovpn"

  name = local.openvpn_name

  instance_type                 = "t3.micro"
  #ami_custom = ""
  #ami                           = false //todo optional argument (custom) // set to false if you want to use custom AMI then add a "ami_custom" argument
  key_name                      = "sandbox-key-2"
  #monitoring                    = true   //todo optional argument
  #vpc_security_group_ids        = ""     //todo optional argument (custom)
  #create_vpc_security_group_ids = "false" //if you want use existing SG, change to false then add an "vpc_security_group_ids" argument. Check the /.terraform/example for more information
  iam_instance_profile          = aws_iam_instance_profile.ssm-profile.name
  vpc_id                        = "vpc-03f2c297f4d834936"
  subnet_id                     = "subnet-0d90013451437020e	"

  tags = merge(local.common_tags, {
    OS     = "Ubuntu",
    Backup = "DailyBackup"
  })
}