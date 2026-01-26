#Define locals values in terraform

locals {
  owners = var.business_division
  environment = var.environment
  name = "${local.owners}-${local.environment}"
  ssh_private_key_path = pathexpand(var.ssh_private_key_path)
  
  app_instance_ids = flatten([
    for m in values(module.ec2_instance_private) : try(m.ids, [m.id])
    ])
  
  common_tags = {
    Owner       = local.owners
    Environment = local.environment
    Terraform   = "true"
  }
}