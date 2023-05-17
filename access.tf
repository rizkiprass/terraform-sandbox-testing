# provider "aws" {
#   access_key = var.access_key
#   secret_key = var.aws_secret_access_key
#   region     = var.aws_region
# }

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
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