module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "pras-server-controller"

  ami = data.aws_ami.ubuntu_20.id
  instance_type          = "t3.micro"
  key_name               = "pras-vivo-key"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  create_iam_instance_profile = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}