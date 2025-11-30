variable "environment" {
  type        = string
  description = "Environment name"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for DB cluster name"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "size" {
  type        = string
  description = "DB size slug (e.g. db-s-1vcpu-1gb)"
}

variable "engine_version" {
  type        = string
  default     = "16"
  description = "Postgres major version"
}

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for DB cluster"
}
