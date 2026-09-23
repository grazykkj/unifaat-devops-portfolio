# s3.tf

# Sufixo aleatório para garantir que o nome do bucket seja globalmente único
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Bucket S3 para armazenar o Terraform State
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project_name}-terraform-state-v2-${random_id.bucket_suffix.hex}"


  object_lock_enabled = false

  tags = {
    Name    = "${var.project_name}-terraform-state"
    Project = "TechNova"
    Aula    = "05"
    Purpose = "Terraform Remote State"
  }
}


# Versionamento do bucket
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Criptografia server-side
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bloqueio de acesso público
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
