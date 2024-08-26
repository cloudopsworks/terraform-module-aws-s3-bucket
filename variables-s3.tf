##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

variable "name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = ""
}

variable "name_prefix" {
  description = "Creates a unique bucket name beginning with the specified prefix. Conflicts with name"
  type        = string
  default     = ""
}

variable "random_bucket_suffix" {
  description = "Creates a unique bucket name with a random 8 character string appended to the end. Defaults to true, for clean names set to false"
  type        = bool
  default     = true
}

variable "short_system_name" {
  description = "Force the use of the short system name local variable, defaults to false."
  type        = bool
  default     = false
}

variable "bucket_config" {
  description = "The configuration for the S3 bucket"
  type        = any
  default     = {}
}
