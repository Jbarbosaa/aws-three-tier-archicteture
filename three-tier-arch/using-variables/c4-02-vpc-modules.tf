module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  # VPC Basic Configuration
    name = "${local.name}-${var.vpc_name}"
    cidr = var.vpc_cidr
    azs = var.vpc_azs
    private_subnets = var.vpc_private_subnets
    public_subnets = var.vpc_public_subnets

    # Database Subnet Configuration
    database_subnets = var.vpc_database_subnets
    create_database_subnet_group = var.create_database_subnet_group
    create_database_subnet_route_table = var.create_database_subnet_route_table
    #create_database_nat_gateway_route = var.create_database_nat_gateway_route
    #create_database_internet_gateway_route = var.create_database_internet_gateway_route

    # NAT Gateways - Outbound Communication for Private Subnets
    enable_nat_gateway = var.create_enable_nat_gateway
    single_nat_gateway = var.create_single_nat_gateway # one NAT Gateway for the entire VPC, not one per AZ (saves money)

    #VPC DNS Support
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = merge(
        local.common_tags,
        {
            Name    = "${local.name}-vpc"
            Project = "MY-VPC-3 TIER ARCHITECTURE"
        }  
    )

    public_subnet_tags = merge(
        local.common_tags,
        {
            Name = "${local.name}-subnet-public"
            Type = "public"
        }  
    )

    private_subnet_tags = merge(
        local.common_tags,
        {
            Name = "${local.name}-subnet-private"
            Type = "private"
        }  
    )

    database_subnet_tags = merge(
        local.common_tags,
        {
            Name = "${local.name}-subnet-database"
            Type = "database"
        }  
    )
}