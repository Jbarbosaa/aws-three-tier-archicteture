resource "aws_db_instance" "rds_instance" {
  identifier              = "${local.name}-rds-instance"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  db_name                 = "${replace(local.name, "-", "_")}_db" # MySQL database names cannot contain hyphens, so we replace them with underscores
  username                = "admin"

  manage_master_user_password = true

  skip_final_snapshot     = true 
  publicly_accessible     = false 
  multi_az = false #save money for demo purposes, not recommended for production
  deletion_protection = false #prevent accidental deletion of the database instance
  apply_immediately = false #apply changes during the next maintenance window, set to true for immediate changes
  backup_retention_period = 7 #retain backups for 7 days, adjust as needed
  backup_window = "03:00-04:00" #schedule backups during off-
  maintenance_window = "Mon:04:00-Mon:05:00" #schedule maintenance during off-hours

  enabled_cloudwatch_logs_exports = [ "error", "general", "slowquery" ]
  
  vpc_security_group_ids = [module.rds_security_group.security_group_id]
  db_subnet_group_name   = module.rds_subnet_group.db_subnet_group_name
  tags                   = local.common_tags
}