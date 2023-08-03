variable "application-port-list" {
  type = map(any)
  default = {
    "http"  = 80
    "https" = 443
    "ssh"   = 22
  }
}

variable "bastion-host-port-list" {
  type = map(any)
  default = {
    "http"  = 80
    "https" = 443
    "ssh"   = 22
  }
}

//bastion sg
resource "aws_security_group" "bastion-sg" {
  name        = format("%s-%s-bastion-sg", var.project, var.environment)
  description = format("%s-%s-bastion-sg", var.project, var.environment)
  vpc_id      = module.vpc.vpc_id
  dynamic "ingress" {
    for_each = var.bastion-host-port-list
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = [
      "0.0.0.0/0"]
      description = ingress.key
    }
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1" //all traffic
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  tags = merge(local.common_tags, {
    Name = format("%s-%s-bastion-sg", var.project, var.environment),
  })
  lifecycle { ignore_changes = [ingress, egress] }

}

resource "aws_security_group" "web-sg" {
  name        = format("%s-%s-web-sg", var.project, var.environment)
  description = format("%s-%s-web-sg", var.project, var.environment)
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = var.application-port-list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [
        var.cidr
      ]
      description = ingress.key
    }
  }
}