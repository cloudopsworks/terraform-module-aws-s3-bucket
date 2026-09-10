##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

output "bucket_id" {
  description = "The name (ID) of the S3 bucket, including the generated prefix and random suffix when enabled."
  value       = module.this.s3_bucket_id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket."
  value       = module.this.s3_bucket_arn
}

output "bucket_regional_domain_name" {
  description = "The region-specific domain name of the S3 bucket, suitable for CloudFront and other regional endpoints."
  value       = module.this.s3_bucket_bucket_regional_domain_name
}

output "bucket_hosted_zone_id" {
  description = "The Route 53 hosted zone ID of the region where the S3 bucket resides."
  value       = module.this.s3_bucket_hosted_zone_id
}

output "bucket_region" {
  description = "The AWS region where the S3 bucket resides."
  value       = module.this.s3_bucket_region
}

output "bucket_website_domain" {
  description = "The domain of the website endpoint, populated only when static website hosting is configured."
  value       = module.this.s3_bucket_website_domain
}

output "bucket_website_endpoint" {
  description = "The website endpoint URL, populated only when static website hosting is configured."
  value       = module.this.s3_bucket_website_endpoint
}
