#!/bin/bash
set -euo pipefail
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

#base

yum update -y
yum install -y jq httpd mysql awscli

# 1 Deploy APP
systemctl enable httpd
systemctl start httpd

cat > /var/www/html/index.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
    <body style="font-family: Arial, sans-serif; text-align: center; margin-top: 50px;">
        <h1 style="color: #333;">Welcome to My AWS App!</h1>
        <p style="color: #555;">This is a simple web application running on an EC2 instance.</p>
    </body>
</html>
HTML

# 2 smoke test no RDS
SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "${rds_secret_arn}" --query SecretString --output text)

DB_USER=$(echo "$SECRET_JSON" | jq -r .username)
DB_PASS=$(echo "$SECRET_JSON" | jq -r .password)

mysql -h "${rds_address}" -P "${rds_port}" -u "${DB_USER}" -p"${DB_PASS}" -e"
CREATE DATABASE IF NOT EXISTS appdb;
USE appdb;
CREATE TABLE IF NOT EXISTS healthcheck (id INT PRIMARY KEY, status VARCHAR(20));
REPLACE INTO healthcheck VALUES (1, 'ok');
SELECT * FROM healthcheck;
"

echo "User data script completed successfully."