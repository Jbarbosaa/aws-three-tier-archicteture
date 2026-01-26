#EC2 Instances Variables
#EC2 Instance Type
variable "ec2_instance_type" {
    description = "EC2 Instance Type"
    type        = string
    default     = "t3.micro"
}

#EC2 Key Pair
variable "ec2_key_name" {
    description = "EC2 Key Pair Name"
    type        = string
    default     = "terraform-aws"
}

#SSH Private Key Path
variable "ssh_private_key_path" {
    description = "Path to the SSH private key file"
    type        = string
    default     = "~/.ssh/terraform-aws.pem"
  
}

#--- IGNORE ---

#AWS EC2 Private Instance Count 
variable "ec2_private_instance_count" {
    description = "Number of Private EC2 Instances"
    type        = number
}
