# Subnet Group - private subnets
resource "aws_db_subnet_group" "priv_subnet_group" {
    name = "${var.project}_subnet_group"
    description = "Subnet group for ${var.project} project"
    subnet_ids = [ aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id ]
    tags = {
        Name = "${var.project}_subnet_group"
    }
}

# Security Group
resource "aws_security_group" "rds_security_group"{
    name = "${var.project}_rds_sg"
    description = "RDS Security Group for ${var.project} project"
    vpc_id = aws_vpc.main.id
    tags = {
    Name = "${var.project}_rds_sg"
  }
}

# RDS Instance - MYSQL 8.0
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  availability_zone = data.aws_availability_zones.available.names[1]
  db_subnet_group_name = aws_db_subnet_group.priv_subnet_group.id
  deletion_protection = true
  engine               = "mysql"
  engine_version       = "8.0"
  identifier            = "${var.project}-mysql"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "admin"
  password             = var.db_password
  publicly_accessible = false
  skip_final_snapshot  = true
  vpc_security_group_ids = [ aws_security_group.rds_security_group.id ]
}
