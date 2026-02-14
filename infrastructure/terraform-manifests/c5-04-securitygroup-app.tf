# AWS EC2 Security Group Terraform Module
# Security group for Private EC2 Instances Hosts

module "app_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "app-sg"
  description = "Security group for app Hosts"
  vpc_id = module.vpc.vpc_id

  # Ingress rules e CIDR Blocks
  ingress_with_source_security_group_id = [
    {
        rule = "http-80-tcp"
        source_security_group_id = module.alb_security_group.security_group_id
    }
  ]

  # Egress rules e CIDR Blocks
    egress_rules = ["all-all"]
    
    tags = merge(
        local.common_tags, 
        {
            Name = "${local.name}-sg-app"
            Type = "app"
            Project = "my-vpc-three-tier-arch"
        }
    )
}