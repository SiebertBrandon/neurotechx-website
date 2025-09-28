variable "app_image" {
  type        = string
  description = "Full image ref to deploy (e.g. ghcr.io/owner/ntx-django:latest or :<sha7>)"
}

variable "ssh_key_name" {
  type        = string
  description = "Name of an SSH key already uploaded to your DO account"
}

variable "name" {
  type        = string
  default     = "django-app"
  description = "Droplet name"
}

variable "domain_name" {
  type        = string
  description = "Root domain hosted in DigitalOcean (e.g., example.com)"
  default     = "" # empty means DNS disabled
}

variable "region" {
  type        = string
}

variable "size" {
  type        = string
}

variable "image_slug" {
  type        = string
  description = "Base OS"
}

# The fully-qualified container image to run (e.g., ghcr.io/owner/django:abc1234)
variable "image" {
  type        = string
  description = "Container image to deploy"
}

# If your GHCR image is private, provide creds; else leave empty strings.
variable "ghcr_user" {
  type        = string
  default     = ""
  description = "GHCR username (usually your GitHub username)"
}

variable "ghcr_token" {
  type        = string
  default     = ""
  sensitive   = true
  description = "GHCR token with read:packages"
}

variable "app_port" {
  type        = number
  default     = 8000
  description = "Port your app listens on inside the container"
}

variable "host_port" {
  type        = number
  default     = 80
  description = "Host port exposed on the droplet"
}

variable "container_env" {
  type        = map(string)
  default     = {}
  description = "Environment variables for the container"
}
