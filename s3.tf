resource "aws_s3_bucket" "test1" {
  bucket = var.s3_name

  tags = {
    Name = var.s3_name
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "test1" {
  bucket = aws_s3_bucket.test1.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "versioning-bucket-config" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.test1]
  bucket     = aws_s3_bucket.test1.bucket
  rule {
    id = "default"
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
    noncurrent_version_expiration {
      noncurrent_days = 28
    }
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "test1" {
  bucket = aws_s3_bucket.test1.bucket
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "test1" {
  bucket = aws_s3_bucket.test1.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "test1" {
  bucket                  = aws_s3_bucket.test1.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
