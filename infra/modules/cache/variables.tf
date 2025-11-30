variable "environment" {
  type        = string
  description = "Environment name"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for cache cluster name"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "size" {
  type        = string
  description = "Cache size slug"
}

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for cache"
}
