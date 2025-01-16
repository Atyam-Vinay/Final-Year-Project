variable "db_username1" {
  description = "Database username"
  default     = "admin_user01"
  
}
variable "db_password1" {
  description = "Database password"
  default     = "admin_password01"
}
variable "region" {
    description = "AWS region"
    default     = "ap-southeast-1"
}
variable "port" {
  description = "port for input and output"
  default     = 3306
}