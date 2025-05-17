# S3 Bucket
resource "aws_s3_bucket" "app_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "NextJS Local App Bucket"
    Environment = "Dev"
  }
}

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name        = "rds_local_sg"
  description = "Allow local access to RDS"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS PostgreSQL
resource "aws_db_instance" "app_db" {
  identifier              = "nextjs-local-db"
  engine                  = "postgres"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  skip_final_snapshot     = true
  publicly_accessible     = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  storage_encrypted       = true
  backup_retention_period = 0
}

# IAM user with S3 access (for local dev app)
resource "aws_iam_user" "app_user" {
  name = "nextjs-app-user"
}

resource "aws_iam_user_policy" "s3_policy" {
  name = "S3FullAccessPolicy"
  user = aws_iam_user.app_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:*"],
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_access_key" "app_user_key" {
  user = aws_iam_user.app_user.name
}

