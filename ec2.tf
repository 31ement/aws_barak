module "webA" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  name          = "webA"
  instance_type = "t2.micro"
  ami           = "ami-0c7217cdde317cfec"
  monitoring    = true
  subnet_id     = module.vpc.private_subnets[0]

  tags = var.aws_default_tag

}

module "webB" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  name          = "webB"
  instance_type = "t2.micro"
  ami           = "ami-0c7217cdde317cfec"
  monitoring    = true
  subnet_id     = module.vpc.private_subnets[1]

  tags = var.aws_default_tag

}
