variable "domain_root" {
  type        = string
  description = "Root domain (e.g. example.com)"
}

variable "domain_website" {
  type        = string
  description = "FQDN for main website (e.g. www.example.com)"
}

variable "domain_api" {
  type        = string
  description = "FQDN for API (e.g. api.example.com)"
}

variable "postgres_size" {
  type        = string
  description = "Managed Postgres size"
}

variable "redis_size" {
  type        = string
  description = "Managed Redis size"
}

variable "enable_github_runner" {
  type        = bool
  default     = true
}
