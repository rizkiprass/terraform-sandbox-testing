resource "aws_ami_copy" "dest" {
  name              = "terraform-example"
  description       = "A copy of ami-xxxxxxxx"
  source_ami_id     = ""
  source_ami_region = "us-west-1"

  tags = {
    Name = "HelloWorld"
  }
}