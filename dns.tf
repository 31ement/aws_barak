module "dns_zones_dev" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.10.2"

  zones = {
    "example.test" = {
      comment = "Dev Test DNS Zone"
    }
  }

  tags = var.aws_default_tag
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.10.2"

  zone_id = module.dns_zones_dev.route53_zone_zone_id["example.com"]

  records = [
    {
      name    = "www"
      type    = "CNAME"
      ttl = 300
      records = [ module.elb_web.elb_dns_name ]
    },
  ]

  depends_on = [module.dns_zones_dev]
}
