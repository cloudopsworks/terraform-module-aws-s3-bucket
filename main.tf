##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  clean_name  = var.name != "" ? var.name : (var.short_system_name == true ? "${var.name_prefix}-${local.system_name_short}" : "${var.name_prefix}-${local.system_name}")
  bucket_name = var.random_bucket_suffix == false ? local.clean_name : "${local.clean_name}-${random_string.random[0].result}"
  versioning = merge(
    try(var.bucket_config.versioning_config, {}),
    {
      enabled = try(var.bucket_config.versioning, false)
    }
  )
}

data "aws_caller_identity" "current" {}

resource "random_string" "random" {
  count   = var.random_bucket_suffix ? 1 : 0
  length  = 8
  special = false
  lower   = true
  upper   = false
  numeric = true
}

module "this" {
  source                                     = "terraform-aws-modules/s3-bucket/aws"
  version                                    = "~> 5.9"
  bucket                                     = local.bucket_name
  acl                                        = try(var.bucket_config.acl, "private")
  control_object_ownership                   = try(var.bucket_config.control_object_ownership, true)
  object_ownership                           = try(var.bucket_config.object_ownership, "ObjectWriter")
  force_destroy                              = try(var.bucket_config.force_destroy, false)
  attach_elb_log_delivery_policy             = try(var.bucket_config.policies.elb_logs, false)
  attach_lb_log_delivery_policy              = try(var.bucket_config.policies.lb_logs, false)
  attach_access_log_delivery_policy          = try(var.bucket_config.policies.access_logs, false)
  attach_deny_insecure_transport_policy      = try(var.bucket_config.policies.deny_insecure_transport, true)
  attach_deny_incorrect_encryption_headers   = try(var.bucket_config.policies.deny_incorrect_encryption, false)
  attach_deny_incorrect_kms_key_sse          = try(var.bucket_config.policies.deny_incorrect_kms_key, false)
  attach_deny_ssec_encrypted_object_uploads  = try(var.bucket_config.policies.deny_ssec_encrypted_uploads, false)
  attach_deny_unencrypted_object_uploads     = try(var.bucket_config.policies.deny_unencrypted_uploads, false)
  attach_waf_log_delivery_policy             = try(var.bucket_config.policies.waf_logs, false)
  attach_cloudtrail_log_delivery_policy      = try(var.bucket_config.policies.cloudtrail_logs, false)
  attach_analytics_destination_policy        = try(var.bucket_config.policies.analytics_destination, false)
  attach_require_latest_tls_policy           = try(var.bucket_config.policies.require_latest_tls, true)
  attach_public_policy                       = try(var.bucket_config.policies.attach_public, true)
  block_public_acls                          = try(var.bucket_config.acls.blocks_public, true)
  block_public_policy                        = try(var.bucket_config.acls.blocks_public_policy, true)
  ignore_public_acls                         = try(var.bucket_config.acls.ignore_public_acls, true)
  restrict_public_buckets                    = try(var.bucket_config.acls.restrict_public_buckets, true)
  server_side_encryption_configuration       = try(var.bucket_config.server_side_encryption_configuration, {})
  attach_policy                              = try(var.bucket_config.policy, "") != ""
  policy                                     = try(var.bucket_config.policy, "") != "" ? replace(var.bucket_config.policy, "{{bucket_name}}", local.bucket_name) : null
  website                                    = try(var.bucket_config.website, {})
  lifecycle_rule                             = try(var.bucket_config.lifecycle_rule, [])
  access_log_delivery_policy_source_accounts = try(var.bucket_config.policies.access_logs, false) ? concat(try(var.bucket_config.policies.access_logs_accounts, []), [data.aws_caller_identity.current.account_id]) : []
  access_log_delivery_policy_source_buckets  = try(var.bucket_config.policies.access_logs, false) ? concat(try(var.bucket_config.policies.access_logs_buckets, []), ["arn:aws:s3:::${local.bucket_name}"]) : []
  transition_default_minimum_object_size     = try(var.bucket_config.transition_default_minimum_object_size, null)
  versioning                                 = local.versioning
  object_lock_enabled                        = try(var.bucket_config.object_lock.enabled, false)
  object_lock_configuration                  = try(var.bucket_config.object_lock.configuration, {})
  replication_configuration                  = try(var.bucket_config.replication, {})
  tags                                       = merge(try(var.bucket_config.tags, {}), local.all_tags)
}