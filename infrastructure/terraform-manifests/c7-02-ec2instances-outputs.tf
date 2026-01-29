# AWS EC2 Instance Terraform Outputs
# ---------------------------------
# Bastion (público) - módulo com COUNT (lista)
# Privadas - módulo com FOR_EACH (map)

# Bastion Host (IDs)
output "bastion_instance_ids" {
  description = "Public EC2 (bastion) instance IDs"
  value       = module.ec2_public[*].id
}

# Bastion Host (Public IPs)
output "bastion_instance_public_ips" {
  description = "Public EC2 (bastion) public IPs"
  value       = module.ec2_public[*].public_ip
}

# -----------------------------
# Instâncias privadas (FOR_EACH)
# -----------------------------

# Private EC2 Instances IDs
output "private_instance_ids" {
  description = "Private EC2 instance IDs"
  value       = [for m in values(module.ec2_instance_private) : m.id]
}

# Private EC2 Instances Private IPs
output "private_instance_private_ips" {
  description = "Private EC2 instance private IPs"
  value       = [for m in values(module.ec2_instance_private) : m.private_ip]
}

# Private EC2 Instances Public IPs (se existirem)
output "private_instance_public_ips" {
  description = "Private EC2 instance public IPs (if any)"
  value       = [for m in values(module.ec2_instance_private) : m.public_ip if m.public_ip != null]
}
