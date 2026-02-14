# Security group for RDS instance
module "rds_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "rds_security_group"
  description = "Security group for RDS instance, allowing MySQL access from the application layer"
  vpc_id = module.vpc.vpc_id

  # Ingress rules e CIDR Blocks
  ingress_with_source_security_group_id = [
    {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        source_security_group_id = module.app_security_group.security_group_id
        description = "Allow MySQL access from application security group"
    }
  ]

  #ingress_cidr_blocks = [module.app_security_group.security_group_id] #allow access only from the application security group

  # Egress rules e CIDR Blocks
    egress_rules = ["all-all"]
    
    tags = merge(
        local.common_tags, 
        {
            Name = "${local.name}-sg-rds"
            Type = "rds"
            Project = "my-vpc-three-tier-arch"
        }
    )
}