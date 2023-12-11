module "sg_vpc_dev" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name   = "vpc-dev-sg"
  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "38.64.208.214/32"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "38.64.208.214/32"
    },
  ]
}