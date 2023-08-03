#module "ec2_instance" {
#  source  = "terraform-aws-modules/ec2-instance/aws"
#
#  name = "pras-server-controller"
#
#  ami = data.aws_ami.ubuntu_20.id
#  instance_type          = "t3.micro"
#  key_name               = "pras-vivo-key"
#  monitoring             = true
#  vpc_security_group_ids = [aws_security_group.web-sg.id]
#  subnet_id              = module.vpc.public_subnets[0]
#  associate_public_ip_address = true
#  create_iam_instance_profile = true
#
#  tags = {
#    Terraform   = "true"
#    Environment = "dev"
#  }
#}

locals {
  multiple_instances = {
    controller = {
      instance_type     = "t3.micro"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp3"
          volume_size = 50
          delete_on_termination = true
        }
      ]
    }
    managed-node-1 = {
      instance_type     = "t3.micro"
      availability_zone = element(module.vpc.azs, 1)
      subnet_id         = element(module.vpc.private_subnets, 1)
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp3"
          volume_size = 50
          delete_on_termination = true
        }
      ]
    }
    managed-node-2 = {
      instance_type     = "t3.micro"
      availability_zone = element(module.vpc.azs, 1)
      subnet_id         = element(module.vpc.private_subnets, 1)
      root_block_device = [
        {
          encrypted   = true
          volume_type = "gp3"
          volume_size = 50
          delete_on_termination = true
        }
      ]
    }
  }
}

module "ec2_multiple" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = local.multiple_instances

  name = "test-multi-${each.key}"

  instance_type          = each.value.instance_type
  availability_zone      = each.value.availability_zone
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  enable_volume_tags = true
  root_block_device  = lookup(each.value, "root_block_device", [])

  tags = merge(local.common_tags, {
    Backup              = "DailyBackup" # TODO: Set Backup Rules
  })
}