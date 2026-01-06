# Security group for Public Load Balancer

module "alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "alb_security_group"
  description = "Security group with HTTP open for entire Internet for Load Balancer"
  vpc_id = module.vpc.vpc_id

  # Ingress rules e CIDR Blocks
  ingress_rules = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Egress rules e CIDR Blocks
    egress_rules = ["all-all"]
    
    tags = merge(
        local.common_tags, 
        {
            Name = "${local.name}-sg-bastion"
            Type = "bastion"
            Project = "MY-VPC-3 TIER ARCHITECTURE"
        }
    )
}