provider "aws" {
  region     = var.aws_region
  access_key = var.access_key_2
  secret_key = var.secret_key_2
}

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "pras"

    workspaces {
      name = "terraform-sandbox-testing"
    }
  }
}