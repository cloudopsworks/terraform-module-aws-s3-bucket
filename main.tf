##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
locals {
  clean_name  = var.name != "" ? var.name : (var.short_system_name == true ? "${var.name_prefix}-${local.system_name_short}" : "${var.name_prefix}-${local.system_name}")
  bucket_name = var.random_bucket_suffix == false ? local.clean_name : "${local.clean_name}-${random_string.random[0].result}"
}

resource "random_string" "random" {
  count   = var.random_bucket_suffix ? 1 : 0
  length  = 8
  special = false
  lower   = true
  upper   = false
  numeric = true
}

module "this" {
  source                                = "terraform-aws-modules/s3-bucket/aws"
  version                               = "4.1.2"
  bucket                                = local.bucket_name
  acl                                   = try(var.bucket_config.acl, "private")
  control_object_ownership              = try(var.bucket_config.control_object_ownership, true)
  object_ownership                      = try(var.bucket_config.object_ownership, "ObjectWriter")
  force_destroy                         = try(var.bucket_config.force_destroy, false)
  attach_elb_log_delivery_policy        = try(var.bucket_config.policies.elb_logs, false)
  attach_lb_log_delivery_policy         = try(var.bucket_config.policies.lb_logs, false)
  attach_deny_insecure_transport_policy = try(var.bucket_config.policies.deny_insecure_transport, true)
  attach_public_policy                  = try(var.bucket_config.policies.public, false)
  block_public_acls                     = try(var.bucket_config.acls.blocks_public, true)
  block_public_policy                   = try(var.bucket_config.acls.blocks_public_policy, true)
  ignore_public_acls                    = try(var.bucket_config.acls.ignore_public_acls, true)
  restrict_public_buckets               = try(var.bucket_config.acls.restrict_public_buckets, true)
  server_side_encryption_configuration  = try(var.bucket_config.server_side_encryption_configuration, {})
  policy                                = try(var.bucket_config.policy, null)
  website                               = try(var.bucket_config.website, {})
  lifecycle_rule                        = try(var.bucket_config.lifecycle_rule, [])
  tags                                  = merge(try(var.bucket_config.tags, {}), local.all_tags)
  versioning = merge(
    try(var.bucket_config.versioning_config, {}),
    {
      enabled = try(var.bucket_config.versioning, false)
    }
  )
}