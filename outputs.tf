output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.this.arn
}

output "kms_key_arn" {
  description = "KMS key used for encryption"
  value       = aws_kms_key.this.arn
}
