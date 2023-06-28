resource "aws_ami_launch_permission" "example" {
  image_id   = aws_ami_copy.test.id
  account_id = "832760563441" #destination account
}