# AWS EC2 Security Group Terraform Module
# Security group for Private EC2 Instances Hosts

module "private_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "private-sg"
  description = "Security group for private Hosts"
  vpc_id = module.vpc.vpc_id

  # Ingress rules e CIDR Blocks
  ingress_rules = ["ssh-tcp", "http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = [var.vpc_cidr]

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