#AWS EC2 Instance Terraform MOdule

#Bastion Host Instance - EC2 Instance that will be created in VPC Public Subnet

module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1"

    name                                = "${var.environment}-bastion"
    ami                                 = data.aws_ami.amzlinux2.id
    instance_type                       = var.ec2_instance_type
    key_name                            = var.ec2_key_name
    subnet_id                           = element(module.vpc.public_subnets, 0)
    vpc_security_group_ids              = [module.public_security_group.security_group_id]
    associate_public_ip_address         = true
    monitoring                          = false
    disable_api_termination             = false
    tags = merge(
        local.common_tags,
        {
            Name = "${local.name}-bastion"
            Project = "MY-VPC-3 TIER ARCHITECTURE"
        }  
    )
}
