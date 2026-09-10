##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = ""
  nullable    = false
}

variable "name_prefix" {
  description = "Creates a unique bucket name beginning with the specified prefix. Conflicts with name"
  type        = string
  default     = ""
  nullable    = false
}

variable "random_bucket_suffix" {
  description = "Creates a unique bucket name with a random 8 character string appended to the end. Defaults to true, for clean names set to false"
  type        = bool
  default     = true
  nullable    = false
}

variable "short_system_name" {
  description = "Force the use of the short system name local variable, defaults to false."
  type        = bool
  default     = false
  nullable    = false
}

## configurations for the S3 bucket - YAML format
#bucket_config: 
#  acl: private | public-read | public-read-write | authenticated-read | log-delivery-write
#                                             # (optional) defaults to null (no ACL is managed).
#                                             # Only valid when object_ownership is ObjectWriter or
#                                             # BucketOwnerPreferred; BucketOwnerEnforced disables ACLs
#                                             # and any acl value will be rejected by AWS.
#  control_object_ownership: true | false     # (optional) defaults to true
#  object_ownership: ObjectWriter | BucketOwnerPreferred | BucketOwnerEnforced
#                                             # (optional) defaults to BucketOwnerEnforced (ACLs disabled).
#                                             # Set to ObjectWriter or BucketOwnerPreferred when the
#                                             # bucket must accept ACL-based writes (e.g. legacy log delivery).
#  force_destroy: true | false                # (optional) defaults to false
#  policies:
#    elb_logs: true | false                   # (optional) defaults to false
#    lb_logs: true | false                    # (optional) defaults to false
#    access_logs: true | false                # (optional) defaults to false
#    deny_insecure_transport: true | false    # (optional) defaults to true
#    deny_incorrect_encryption: true | false  # (optional) defaults to false
#    deny_incorrect_kms_key: true | false     # (optional) defaults to false
#    deny_ssec_encrypted_uploads: true | false # (optional) defaults to false
#    deny_unencrypted_uploads: true | false   # (optional) defaults to false
#    require_latest_tls: true | false         # (optional) defaults to true
#    attach_public: true | false              # (optional) defaults to true
#    waf_logs: true | false                   # (optional) defaults to false
#    cloudtrail_logs: true | false            # (optional) defaults to false
#    analytics_destination: true | false      # (optional) defaults to false
#    access_logs_accounts: []                 # (optional) list of additional AWS account IDs for access log delivery policy
#    access_logs_buckets: []                  # (optional) list of additional source bucket ARNs for access log delivery policy
#  acls:
#    blocks_public: true | false              # (optional) defaults to true
#    blocks_public_policy: true | false       # (optional) defaults to true
#    ignore_public_acls: true | false         # (optional) defaults to true
#    restrict_public_buckets: true | false    # (optional) defaults to true
#  server_side_encryption_configuration: # (optional) defaults to {}
#    rule:
#      apply_server_side_encryption_by_default:
#        sse_algorithm: AES256 | aws:kms
#        kms_master_key_id: <KMS Key ARN> # (optional) only if sse_algorithm is aws:kms
#  policy: <JSON policy> # (optional) defaults to ""
#  website: # (optional) defaults to {}
#    index_document: index.html
#    error_document: error.html
#    redirect_all_requests_to: # (optional)
#      host_name: <host name>
#      protocol: <http | https>
#    routing_rules: # (optional) defaults to []
#      - condition: # (optional)
#          http_error_code_returned_equals: <error code>
#          key_prefix_equals: <prefix>
#        redirect:
#          host_name: <host name>
#          protocol: <http | https>
#          http_redirect_code: <redirect code> # (optional)
#          replace_key_prefix_with: <prefix> # (optional)
#          replace_key_with: <key> # (optional)
#  versioning: true | false                   # (optional) defaults to false - enable/disable versioning
#  versioning_config: # (optional) defaults to {}
#    mfa: <MFA KEY + code>                    # (optional) MFA device ARN and token for MFA-delete
#    status: Enabled | Suspended              # (ignored) the upstream module always derives the status
#                                             # from `versioning` above; set `versioning` instead
#    mfa_delete: Enabled | Disabled           # (optional) defaults to Disabled
#  lifecycle_rule: # (optional) defaults to []
#    - id: <rule ID> # (optional)
#      enabled: true | false # (optional) defaults to true
#      status: true | false # (optional) defaults to true
#      abort_incomplete_multipart_upload_days: <days> # (optional)
#      expiration: # (optional)
#        date: <date> # (optional)
#        days: <days> # (optional)
#        expired_object_delete_marker: true | false # (optional) defaults to false
#      transition: # (optional)
#        - date: <date> # (optional)
#          days: <days> # (optional)
#          storage_class: GLACIER | DEEP_ARCHIVE | INTELLIGENT_TIERING | ONEZONE_IA | STANDARD_IA | STANDARD # (optional)
#      noncurrent_version_expiration: # (optional)
#        days: <days> # (optional)
#        newer_noncurrent_versions: <number> # (optional)
#      noncurrent_version_transition: # (optional)
#        - days: <days> # (optional)
#          newer_noncurrent_versions: <number> # (optional)
#          storage_class: GLACIER | DEEP_ARCHIVE | INTELLIGENT_TIERING | ONEZONE_IA | STANDARD_IA | STANDARD # (optional)
#      filter: # (optional)
#        prefix: <prefix> # (optional)
#        object_size_greater_than: <size> # (optional)
#        object_size_less_than: <size> # (optional)
#        tags: # (optional) defaults to {}
#          key: value # (optional) additional tags can be added here
#  transition_default_minimum_object_size: <size> # (optional) defaults to null
#  object_lock: # (optional) defaults to {}
#    enabled: true | false # (optional) defaults to false
#    configuration: # (optional) defaults to {}
#      rule:
#        default_retention: # (optional)
#          mode: COMPLIANCE | GOVERNANCE # (optional)
#          days: <days> # (optional)
#          years: <years> # (optional)
#  replication: # (optional) defaults to {}
#    role: <IAM role ARN> # (required)
#    rules: # (required)
#      - id: <rule ID> # (required)
#        status: true | false # (required)
#        delete_marker_replication: true | false # (optional) defaults to null
#        destination: # (required)
#          bucket: <destination bucket ARN> # (required)
#          storage_class: GLACIER | DEEP_ARCHIVE | INTELLIGENT_TIERING | ONEZONE_IA | STANDARD_IA | STANDARD # (optional)
#          account: <destination account ID> # (optional)
#          access_control_translation: # (optional)
#            owner: BucketOwner # (optional) defaults to BucketOwner
#          encryption_configuration: # (optional)
#            replica_kms_key_id: <KMS Key ARN> # (optional) only if encryption is required
#          replication_time: # (optional)
#            status: true | false # (required) defaults to false
#            minutes: <minutes> # (required)
#          metrics: # (optional)
#            status: true | false # (required) defaults to false
#            minutes: <minutes> # (required)
#        source_selection_criteria: # (optional)
#          replica_modifications: # (optional)
#            enabled: true | false # (optional) defaults to false
#          sse_kms_encrypted_objects: # (optional)
#            enabled: true | false # (optional) defaults to false
#        filter: # (optional)
#          prefix: <prefix> # (optional)
#          tags: # (optional) defaults to {}
#            key: value # (optional) additional tags can be added here
#  tags: # (optional) defaults to {}
#    key: value # (optional) additional tags can be added here
variable "bucket_config" {
  description = "The configuration for the S3 bucket"
  type        = any
  default     = {}
}
