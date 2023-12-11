aws_credentials = [
  "~/.aws/credentials"
]
aws_profile        = "default"
aws_default_region = "us-east-1"
vpc_dev = {
  name                  = "vpc_dev"
  cidr                  = "10.100.0.0/16"
  azs                   = ["us-east-1a", "us-east-1b"]
  default_vpc           = false
  private_subnets       = ["10.100.0.0/24", "10.100.1.0/24"]
  private_subnets_names = ["PrivateA", "PrivateB"]
  public_subnets        = ["10.100.100.0/24", "10.100.101.0/24"]
  public_subnets_names  = ["PublicA", "PublicB"]
  tags = {
    env   = "dev"
    owner = "devops"
  }
}