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