resource "aws_s3_bucket" "msd_bucket" {
  bucket = var.bucket-name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  policy        = var.policy
  force_destroy = var.enable-deletion-protection ? false : true

  tags = {
    "Name"              = var.bucket-name
    "Application"  = var.appname
    "Application Owner" = var.appowner
    "Environment"       = var.environment
    "Application Role"  = var.approle
    "Deployment id"     = var.deployment-id
  }
}

output "s3_name" {
  value = aws_s3_bucket.msd_bucket.id
}

output "s3_arn" {
  value = aws_s3_bucket.msd_bucket.arn
}

output "s3_domain" {
  value = aws_s3_bucket.msd_bucket.bucket_domain_name
}
