resource "aws_ami_copy" "dest" {
  name              = "terraform-example"
  description       = "A copy of ami-xxxxxxxx"
  source_ami_id     = aws_ami_copy.test.id
  source_ami_region = "us-west-2"

  tags = {
    Name = "HelloWorld"
  }

  provider = "dest"
}