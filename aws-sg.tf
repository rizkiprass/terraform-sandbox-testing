variable "application-port-list" {
  type = map(any)
  default = {
    "http"  = 80
    "https" = 443
    "ssh"   = 22
  }
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