variable "aws_region" {
  description = "AWS Region"
  default     = "eu-west-2"
}

variable "region" {
  default = ""
}

variable "access_key" {}

variable "secret_key" {}

#variable "access_key_2" {}
#
#variable "secret_key_2" {}
#
#variable "access_key_3" {}
#variable "secret_key_3" {}

variable "region" {
  default = "eu-west-2"
}

// Tag
variable "Birthday" {
  default = "26-01-2022"
}

variable "Backup" {
  default = "BackupDaily"
}

variable "cidr" {
  default = "30.0.0.0/16"
}

variable "cidr2" {
  default = "30.1.0.0/16"
}

variable "Public_Subnet_AZA_1" {
  default = "30.0.0.0/24"
}
variable "Public_Subnet_AZA_2" {
  default = "30.0.1.0/24"
}

variable "Public_Subnet_AZB_1" {
  default = "30.0.2.0/24"
}

variable "Public_Subnet_AZB_2" {
  default = "30.0.3.0/24"
}

variable "App_Subnet_AZA" {
  default = "30.0.10.0/24"
}

variable "App_Subnet_AZB" {
  default = "30.0.11.0/24"
}

variable "Data_Subnet_AZA" {
  default = "30.0.20.0/24"
}

variable "Data_Subnet_AZB" {
  default = "30.0.21.0/24"
}

#ami

variable "ami-ubuntu" {
  default = "ami-04505e74c0741db8d"
}

variable "ami-linux2" {
  default = "ami-05fa00d4c63e32376"
}

#Tagging Common
variable "environment" {
  default = "prod"
}

variable "environment_dev" {
  default = "dev"
}
variable "project" {
  default = "pras"
}

locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = "Yes"
  }

  common_tags_dev = {
    Project     = var.project
    Environment = var.environment_dev
    Terraform   = "Yes"
  }
}

variable "customer" {
  default = "pras"
}

#key
variable "key-bastion-inject" {
  default = "bastion-inject"
}

variable "key-sandbox-prod-app" {
  default = "key-sandbox-prod-app"
}

variable "key-sandbox-dev-app" {
  default = "key-sandbox-dev-app"
}

variable "key-sandbox-data" {
  default = "key-sandbox-data"
}

variable "key-sandbox-openvpn" {
  default = "key-sandbox-openvpn"
}

