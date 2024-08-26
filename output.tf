##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

output "bucket_id" {
  value = module.this.s3_bucket_id
}
output "bucket_arn" {
  value = module.this.s3_bucket_arn
}

output "bucket_regional_domain_name" {
  value = module.this.s3_bucket_bucket_regional_domain_name
}

output "bucket_hosted_zone_id" {
  value = module.this.s3_bucket_hosted_zone_id
}

output "bucket_region" {
  value = module.this.s3_bucket_region
}

output "bucket_website_domain" {
  value = module.this.s3_bucket_website_domain
}

output "bucket_website_endpoint" {
  value = module.this.s3_bucket_website_endpoint
}