module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.2.0"

  name = var.vpc_dev.name
  cidr = var.vpc_dev.cidr

  azs                  = var.vpc_dev.azs
  private_subnets      = var.vpc_dev.private_subnets
  private_subnet_names = var.vpc_dev.private_subnets_names
  public_subnets       = var.vpc_dev.public_subnets
  public_subnet_names  = var.vpc_dev.public_subnets_names

  manage_default_vpc     = var.vpc_dev.default_vpc
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  external_nat_ip_ids    = aws_eip.vpc_dev_eip.*.id

  enable_vpn_gateway            = false
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false


  tags = var.vpc_dev.tags
}

resource "aws_eip" "vpc_dev_eip" {
  count = length(var.vpc_dev.azs)
  tags  = var.vpc_dev.tags
}