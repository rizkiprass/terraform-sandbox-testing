resource "aws_ami_copy" "test" {
  name              = aws_ami_from_instance.example.name
  description       = "A copy of ${aws_ami_from_instance.example.id} (cmk)"
  source_ami_id     = aws_ami_from_instance.example.id
  source_ami_region = "us-west-2"
  encrypted = "true"
  kms_key_id = "arn:aws:kms:us-west-2:272547513321:key/2b4ec77f-9419-4d5b-83a3-1b1eef55605a"

  tags = {
    Name = "ami-name"
  }

  depends_on = [aws_ami_from_instance.example]
}

output "ami_id" {
  value = aws_ami_copy.test.id
}