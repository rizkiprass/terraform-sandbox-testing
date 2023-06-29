locals {
  openvpn_name = format("%s-%s-openvpn", var.customer, var.environment)
}

module "ovpn_instance" {
  source = "./modules/ovpn"

  name = local.openvpn_name

  instance_type                 = "t3.micro"
  #ami_custom = ""
  #ami                           = false //todo optional argument (custom) // set to false if you want to use custom AMI then add a "ami_custom" argument
  key_name                      = "pras-key-2"
  #monitoring                    = true   //todo optional argument
  #vpc_security_group_ids        = ""     //todo optional argument (custom)
  #create_vpc_security_group_ids = "false" //if you want use existing SG, change to false then add an "vpc_security_group_ids" argument. Check the /.terraform/example for more information
  iam_instance_profile          = aws_iam_instance_profile.ssm-profile.name
  vpc_id                        = "vpc-044dd042a5f048a3e"
  subnet_id                     = "subnet-040984d3d48d92f1f"

  tags = merge(local.common_tags, {
    OS     = "Ubuntu",
    Backup = "DailyBackup"
  })
}