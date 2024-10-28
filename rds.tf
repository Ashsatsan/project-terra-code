resource "aws_instance" "bastion" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  key_name               = aws_key_pair.proj1.key_name
  tags = {
    Name = "BastionHost"
  }
}

# Create Application EC2 Instance
resource "aws_instance" "app_instance" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  key_name               = aws_key_pair.proj1.key_name
  vpc_security_group_ids = [aws_security_group.app_instance_sg.id]

  # User data to install MySQL, download db_backup.sql, and import it
  user_data = <<-EOF
              #!/bin/bash
              # Update the package repository
              yum update -y

              # Install MySQL and wget
              yum install -y mysql wget

              # Start MySQL service
              systemctl start mysqld
              systemctl enable mysqld


              # Download the SQL backup file
              wget https://raw.githubusercontent.com/hkhcoder/vprofile-project/refs/heads/main/src/main/resources/db_backup.sql -O /tmp/db_backup.sql

              # Import the SQL file into MySQL

               mysql -u ${var.mysql_username} -p'${var.mysql_password}

              # Optional: Clean up the SQL file after import
              rm /tmp/db_backup.sql
              EOF

  tags = {
    Name = "AppInstance"
  }
}

resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  engine             = "mysql"
  engine_version     = "8.0"
  instance_class     = "db.t2.micro"
  name                = "mydatabase"
  username            = var.mysql_username
  password            = var.mysql_password
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot = true

  tags = {
    Name = "MyRDSInstance"
  }
}

# Create a DB Subnet Group for RDS
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet.id] # Use your private subnet ID(s)

  tags = {
    Name = "MyDBSubnetGroup"
  }
}
