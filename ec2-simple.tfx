resource "aws_instance" "web" {
  ami           = "ami-01e14db03a359ff18"
  instance_type = "t3.micro"

  root_block_device {

    tags = merge(local.common_tags, {
      Name = "test-root-ebs"
    })
  }

  ebs_block_device {
    device_name           = "/dev/sdb"
    tags = merge(local.common_tags, {
      Name = "test-ebs-block"
    })
  }

  tags = {
    Name = "HelloWorld"
  }
}