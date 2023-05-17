module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "20.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = ["20.0.1.0/24", "20.0.2.0/24"]
  public_subnets  = ["20.0.101.0/24", "20.0.102.0/24"]
  intra_subnets    = ["20.0.21.0/24", "20.0.22.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}