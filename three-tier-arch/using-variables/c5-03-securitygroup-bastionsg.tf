# AWS EC2 Security Group Terraform Module
# Security group for Public Bastion Hosts

module "public_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "public-bastion-sg"
  description = "Security group for Public Bastion Hosts"
  vpc_id = module.vpc.vpc_id

  # Ingress rules e CIDR Blocks
  ingress_rules = ["ssh-tcp"]
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
