resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu_20.id
  instance_type = "t3.micro"
  key_name      = "pras-vivo-key"


  root_block_device {

    tags = merge(local.common_tags, {
      Name = "test-root-ebs"
    })
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    tags = merge(local.common_tags, {
      Name = "test-ebs-block"
    })
  }

  tags = {
    Name = "HelloWorld"
  }
}