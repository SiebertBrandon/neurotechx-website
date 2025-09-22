terraform {
  required_version = ">= 1.6"
  required_providers {
    digitalocean = { source = "digitalocean/digitalocean", version = "~> 2.39" }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# SSH key already uploaded to DO (or create with resource "digitalocean_ssh_key")
data "digitalocean_ssh_key" "me" {
  name = var.ssh_key_name
}

resource "digitalocean_droplet" "app" {
  name   = var.droplet_name
  region = var.region           # e.g., "nyc3"
  size   = var.size             # e.g., "s-1vcpu-1gb"
  image  = var.os_image        # e.g., "ubuntu-24-04-x64"
  backups = false

  ssh_keys = [data.digitalocean_ssh_key.me.id]

  user_data = file("${path.module}/cloudinit.yaml")

  monitoring = true

  tags = ["app", "docker"]
}

resource "digitalocean_firewall" "fw" {
  name = "${var.droplet_name}-fw"
  droplet_ids = [digitalocean_droplet.app.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.admin_cidrs # e.g., ["0.0.0.0/0"] to start, tighten later
  }

  inbound_rule { protocol = "tcp"; port_range = "80";  source_addresses = ["0.0.0.0/0"] }
  inbound_rule { protocol = "tcp"; port_range = "443"; source_addresses = ["0.0.0.0/0"] }

  outbound_rule { protocol = "tcp"; port_range = "1-65535"; destination_addresses = ["0.0.0.0/0"] }
  outbound_rule { protocol = "udp"; port_range = "1-65535"; destination_addresses = ["0.0.0.0/0"] }
  outbound_rule { protocol = "icmp"; destination_addresses = ["0.0.0.0/0"] }
}

# Domains and DNS records
resource "digitalocean_domain" "domain" { name = var.domain }
resource "digitalocean_record" "root_a" {
  domain = digitalocean_domain.domain.name
  type   = "A"
  name   = "@"
  value  = digitalocean_droplet.app.ipv4_address
}
resource "digitalocean_record" "grafana" {
  domain = digitalocean_domain.domain.name
  type   = "A"
  name   = "grafana"
  value  = digitalocean_droplet.app.ipv4_address
}
resource "digitalocean_record" "prometheus" {
  domain = digitalocean_domain.domain.name
  type   = "A"
  name   = "prometheus"
  value  = digitalocean_droplet.app.ipv4_address
}