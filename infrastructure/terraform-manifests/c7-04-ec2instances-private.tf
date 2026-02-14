#AWS EC2 Instance Terraform MOdule

#Bastion Host Instance - EC2 Instance that will be created in VPC Public Subnet

module "ec2_instance_private" {

    depends_on = [ module.vpc ] //depends on VPC module to provide internet to the private hosts, when the instance will use amazon repository

    source  = "terraform-aws-modules/ec2-instance/aws"
    version = "6.1.1"

    for_each = { for idx, subnet_id in module.vpc.private_subnets : idx => subnet_id }

    name                                = "${var.environment}-private-vm"
    ami                                 = data.aws_ami.amzlinux2.id
    instance_type                       = var.ec2_instance_type
    iam_instance_profile                = aws_iam_instance_profile.ssm_instance_profile.name
    subnet_id                           = each.value
    vpc_security_group_ids              = [module.app_security_group.security_group_id]
    associate_public_ip_address         = false
    monitoring                          = false
    disable_api_termination             = false

    user_data = templatefile("${path.root}/../../application/user-data.sh.tpl", {
        rds_address = aws_db_instance.rds_instance.address
        rds_port = aws_db_instance.rds_instance.port
        rds_secret_arn = aws_db_instance.rds_instance.master_user_secret[0].secret_arn
    }) //script to install user-data on the instance

    tags = merge(
        local.common_tags,
        {
            Name = "${local.name}-private-vm"
            Project = "my-vpc-application"
        }  
    )

    metadata_options = {
        http_endpoint = "enabled" //enable IMDS for instance metadata access
        http_tokens = "required" //require IMDSv2 for enhanced security
        http_put_response_hop_limit = 1 //limit the number of hops for IMDS requests to prevent SSRF attacks
    }

}
