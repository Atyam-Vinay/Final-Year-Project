provider "aws" {
    region = var.region
}
resource "aws_db_instance" "name" {

    identifier_prefix= "attendence-database"
    engine = "mysql"
    instance_class = "db.t3.micro"
    allocated_storage = 10
    storage_type = "gp2"
    db_name = "CSBS_attendence"
    storage_encrypted = true
    skip_final_snapshot = true
    username = var.db_username1
    password = var.db_password1
    publicly_accessible =true
    vpc_security_group_ids = [aws_security_group.db_security_group.id]
}
terraform{
    backend "s3" {
    bucket="attendance-project-tfstate"
    key="infrastructure-setup/Database-setup/rds.tfstate"
    region="ap-south-1"
    dynamodb_table = "project-locks-tf-state"
    encrypt = true
    }
}
resource "aws_security_group" "db_security_group" {
    name="attendence-db-security-group"
    ingress {
        from_port=var.port
        to_port=var.port
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
  
}