variable "do_token" {
  type        = string
  sensitive   = true
  description = "DigitalOcean API token"
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

variable "region" {
  type        = string
  default     = "nyc3"
}

variable "size" {
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "image_slug" {
  type        = string
  default     = "ubuntu-24-04-x64"
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
