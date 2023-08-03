resource "aws_instance" "web-app" {
  ami                         = data.aws_ami.ubuntu_20.id
  instance_type               = "t3.micro"
  associate_public_ip_address = "false"
  key_name                    = "pras-vivo-key"
  subnet_id                   = module.vpc.public_subnets[0]
  iam_instance_profile        = aws_iam_instance_profile.ssm-profile.name
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]
  root_block_device {
    volume_size           = 256
    volume_type           = "gp3"
    iops                  = 3000
    encrypted             = true
    delete_on_termination = true
    tags = merge(local.common_tags, {
        Name = format("%s-%s-web-ebs", var.customer, var.environment)
    })
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(local.common_tags, {
    Name                = format("%s-%s-bastion", var.customer, var.environment),
    OS                  = "Centos",
    Backup              = "DailyBackup" # TODO: Set Backup Rules
  })
}