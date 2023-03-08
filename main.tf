provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "rds_security_group" {
  name_prefix = "rds_sg_"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = ["subnet-a", "subnet-b", "subnet-c"]
}

resource "aws_db_instance" "db_instance" {
  identifier            = "my-db-instance"
  engine                = "mysql"
  engine_version        = "8.0.23"
  instance_class        = "db.t3.medium"
  allocated_storage     = 100
  storage_type          = "gp2"
  username              = "admin"
  password              = "admin"
  db_subnet_group_name  = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
	
  multi_az = true

  tags = {
    Name = "my-db-instance"
  }
}
