resource "aws_ami_from_instance" "example" {
  name               = "tf-ami"
  source_instance_id = "i-09406c9b3998a0011"
  snapshot_without_reboot = "true"
}

#output "ami_id" {
#  value = aws_ami_from_instance.example.id
#}