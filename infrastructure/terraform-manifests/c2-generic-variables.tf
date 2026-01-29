# Input Variables

# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}

# Environment for resource tagging
variable "environment" {
  description = "Environment for resource tagging"
  type        = string
  default     = "dev"
}

# Business Division for resource tagging
variable "business_division" {
  description = "Business Division for resource tagging"
  type        = string
  default     = "IT"
  
}