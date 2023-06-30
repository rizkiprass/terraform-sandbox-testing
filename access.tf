# provider "aws" {
#   access_key = var.access_key
#   secret_key = var.aws_secret_access_key
#   region     = var.aws_region
# }

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key_3
  secret_key = var.secret_key_3
}

#terraform {
#  backend "remote" {
#    hostname = "app.terraform.io"
#    organization = "pras"
#
#    workspaces {
#      name = "aws-arch-v2-03-01-23"
#    }
#  }
#}

## This provider uses the "prod" alias
#  provider "aws" {
#    alias = "dest"
#
#    access_key = var.access_key_2
#    secret_key = var.secret_key_2
#    region = "us-east-1"
#  }

terraform {
  cloud {
    hostname = "app.terraform.io" # Optional for TFC
    organization = "pras"

    workspaces {
      name = "terraform-sandbox-testing"
    }
  }
}