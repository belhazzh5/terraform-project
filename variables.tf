# --- variables.tf ---
variable "aws_region" {
  default = "us-east-1"
}
variable "s3_bucket_name" {
  default = "nextjs-local-app-bucket"
}

variable "db_name" {
  default = "nextjsdb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default = "MySecurePassword123!"
  sensitive = true
}

variable "allowed_ip" {
  default = "102.104.185.169/32"
}

