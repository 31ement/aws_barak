# Infrastructure Setup Guide

This code creates the following AWS resources:

## Resources

1. **VPC with Four Subnets:**
   - A Virtual Private Cloud (VPC) with two public and two private subnets.

2. **Route Tables for Each Subnet:**
   - Separate route tables for public and private subnets.

3. **Security Group:**
   - A security group to allow inbound traffic on ports 80 (HTTP) and 443 (HTTPS) from the internet.

4. **Elastic Load Balancer (ELB):**
   - An ELB configured to listen on ports 80 and 443.

5. **Route53 Hosted Zone and CNAME Entry:**
   - A public Route53 hosted zone.
   - A CNAME entry for the ELB.
