# Elastic IP for Bastion Host
# Resource - depends_on - to make sure that EIP is created after the IGW

resource "aws_eip" "bastion_eip" {

    depends_on = [ 
        module.vpc,
        module.ec2_public
    ] //depends on IGW module to provide internet to the bastion host
    instance = module.ec2_public.id
    domain   = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-bastion-eip"
      Project = "MY-VPC-3 TIER ARCHITECTURE"
    }  
  )
}