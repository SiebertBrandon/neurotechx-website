variable "do_token"       { type = string, sensitive = true }
variable "droplet_name"   { type = string }
variable "region"         { type = string }
variable "size"           { type = string }
variable "admin_cidrs"    { type = list(string) }
variable "domain"         { type = string }
variable "os_image"       { type = string }
# e.g., "ubuntu-24-04-x64", "debian-12-x64", "fedora-38-x64", "centos-9-x64"
# See https://www.digitalocean.com/docs/images/ for options
# For Docker, Ubuntu or Debian are recommended.
