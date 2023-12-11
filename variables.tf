variable "aws_credentials" {
  type        = list(any)
  description = "AWS Credentials file"
}

variable "aws_profile" {
  type        = string
  description = "AWS Credentials Profile"
}

variable "aws_default_region" {
  type        = string
  description = "AWS Default Region"
}

variable "aws_default_tag" {
  type = object({
    env   = string
    owner = string
  })
  default = {
    env   = "dev"
    owner = "devops"
  }
}

variable "vpc_dev" {
  type = object({
    name                  = string
    cidr                  = string
    azs                   = list(string)
    default_vpc           = bool
    private_subnets       = list(string)
    private_subnets_names = list(string)
    public_subnets        = list(string)
    public_subnets_names  = list(string)
    tags = object({
      env   = string
      owner = string
    })
  })
}
