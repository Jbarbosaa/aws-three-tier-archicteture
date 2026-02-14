output "RDS_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.rds_instance.address
}

output "RDS_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.rds_instance.port
}

output "rds_master_secret_arn" {
  description = "The secret ARN of the RDS instance master user"
  value       = aws_db_instance.rds_instance.master_user_secret[0].secret_arn
}