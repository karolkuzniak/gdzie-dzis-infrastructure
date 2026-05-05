output "bucket_name" {
  value = aws_s3_bucket.main.bucket
}

output "bucket_arn" {
  description = "bucket ARN, required for IAM permissions"
  value       = aws_s3_bucket.main.arn
}
