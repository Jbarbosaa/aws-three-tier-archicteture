#VPC Input Variables

#VPC Name
 
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "myvpc"
}

#VPC CIDR Block

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

#Availability Zones
variable "vpc_azs" {
    description = "List of Availability Zones"
    type        = list(string)
    default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

#Public Subnets
variable "vpc_public_subnets" {
    description = "List of Public Subnets"
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

#Private Subnets
variable "vpc_private_subnets" {
    description = "List of Private Subnets"
    type        = list(string)
    default     = ["10.0.101.0/24", "10.0.102.0/24"]
}
#Database Subnets
variable "vpc_database_subnets" {
    description = "List of Database Subnets"
    type        = list(string)
    default     = ["10.0.151.0/24", "10.0.152.0/24"]
}

# VPC Create Database Subnet Group
variable "create_database_subnet_group" {
    description = "Create Database Subnet Group"
    type        = bool
    default     = true
}

# VPC Create Database Subnet Route Table
variable "create_database_subnet_route_table" {
    description = "Create Database Subnet Route Table"
    type        = bool
    default     = true
}   

# VPC Create Database NAT Gateway Route
variable "create_enable_nat_gateway" {
    description = "Enable NAT gateway for private subnets outbund communication"
    type        = bool
    default     = true
}

# VPC Single NAT Gateway
variable "create_single_nat_gateway" {
    description = "Create single NAT gateway for the entire VPC (not one per AZ, saves money)"
    type        = bool
    default     = true
}
