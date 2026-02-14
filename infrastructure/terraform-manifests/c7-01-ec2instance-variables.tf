#EC2 Instances Variables
#EC2 Instance Type
variable "ec2_instance_type" {
    description = "EC2 Instance Type"
    type        = string
    default     = "t3.micro"
}
#--- IGNORE ---

#AWS EC2 Private Instance Count 
variable "ec2_private_instance_count" {
    description = "Number of Private EC2 Instances"
    type        = number
}
