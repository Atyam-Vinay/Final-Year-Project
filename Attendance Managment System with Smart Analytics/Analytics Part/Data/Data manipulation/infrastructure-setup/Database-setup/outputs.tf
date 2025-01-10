output "endpoint" {
    value = aws_db_instance.name.address
    description = "The endpoint of the RDS instance"
}
output "port" {
    value = aws_db_instance.name.port
    description = "the port of the RDS instance"
}