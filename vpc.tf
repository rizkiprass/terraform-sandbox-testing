module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"
  # insert the 14 required variables here
  name                             = format("%s-%s-VPC", var.project, var.environment)
  cidr                             = var.cidr
  enable_dns_hostnames             = true
  enable_dhcp_options              = true
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]
  azs                              = ["${var.region}a", "${var.region}b"]
  public_subnets                   = [var.Public_Subnet_AZA_1, var.Public_Subnet_AZB_2]
  private_subnets                  = [var.App_Subnet_AZA, var.App_Subnet_AZB]
  # intra_subnets                    = [var.Data_Subnet_AZ1, var.Data_Subnet_AZ2] //this is subnet only route to local vpc
  database_subnets                 = [var.Data_Subnet_AZA, var.Data_Subnet_AZB] // subnet db route to nat
  # Nat Gateway
  enable_nat_gateway = true
  single_nat_gateway = true #if true, nat gateway only create one
  # Reuse NAT IPs
  reuse_nat_ips         = true                         # <= if true, Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids   = [aws_eip.eip-nat-sandbox.id] #attach eip from manual create eip
  public_subnet_suffix  = "public"
  private_subnet_suffix = "private"
  intra_subnet_suffix   = "db"
  #  intra_subnet_suffix   = "data"
  tags = local.common_tags
  #  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  #  enable_flow_log                      = true
  #  create_flow_log_cloudwatch_log_group = true
  #  create_flow_log_cloudwatch_iam_role  = true
  #  flow_log_max_aggregation_interval    = 60
  #  flow_log_cloudwatch_log_group_kms_key_id = module.kms-cwatch-flowlogs-kms.key_arn



  #  //tags for vpc flow logs
  #  vpc_flow_log_tags = {
  #    Name = format("%s-%s-vpc-flowlogs", var.customer, var.environment)
  #  }
}

//eip for nat
resource "aws_eip" "eip-nat-sandbox" {
  vpc = true
  tags = merge(local.common_tags, {
    Name = format("%s-prod-EIP", var.project)
  })
}
