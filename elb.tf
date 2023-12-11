module "elb_web" {
  source  = "terraform-aws-modules/elb/aws"
  version = "4.0.1"

  name = "elb-web"

  subnets         = module.vpc.private_subnets.*
  security_groups = [module.sg_vpc_dev.security_group_id]
  internal        = false

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    # {
    #   instance_port     = 443
    #   instance_protocol = "https"
    #   lb_port           = 443
    #   lb_protocol       = "https"
    # },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  // ELB attachments
  number_of_instances = 2
  instances           = [module.webA.id, module.webB.id]

  tags = var.aws_default_tag
}