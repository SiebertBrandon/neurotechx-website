terraform {
  required_version = ">= 1.6.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.40"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2"
    }
  }

  backend "s3" {}
}

provider "digitalocean" {
  token = var.do_token
}

# SSH key already uploaded to DO (or create with resource "digitalocean_ssh_key")
data "digitalocean_ssh_key" "deploy_key" {
  name = var.ssh_key_name
}

data "template_file" "cloud_init" {
  template = file("${path.module}/cloud-init.tftpl")
  vars = {
    docker_image = local.docker_image
    ghcr_user    = var.ghcr_user
    ghcr_token   = var.ghcr_token
    app_port     = var.app_port
    host_port    = var.host_port
    env_lines    = join("\n", [for k, v in var.container_env : "Environment=${k}=${v}"])
  }
}

resource "digitalocean_droplet" "app" {
  name   = var.droplet_name
  region = var.region           # e.g., "nyc3"
  size   = var.size             # e.g., "s-1vcpu-1gb"
  image  = var.os_image        # e.g., "ubuntu-24-04-x64"
  backups = false
  ssh_keys = [data.digitalocean_ssh_key.deploy_key.id]
  user_data          = data.template_file.cloud_init.rendered
  monitoring = true
  graceful_shutdown  = true
  tags = ["app", "docker"]
}

resource "digitalocean_firewall" "fw" {
  name = "${var.droplet_name}-fw"
  droplet_ids = [digitalocean_droplet.app.id]

  inbound_rule { # SSH from admin CIDRs
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.admin_cidrs
  }
  inbound_rule { # HTTP and HTTPS from anywhere
    protocol = "tcp"
    port_range = "80"
    source_addresses = ["0.0.0.0/0"]
  }
  inbound_rule { # HTTPS from anywhere
    protocol = "tcp"
    port_range = "443"
    source_addresses = ["0.0.0.0/0"]
  }

  outbound_rule { # All outbound
    protocol = "tcp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
  outbound_rule { # All outbound
    protocol = "udp"
    port_range = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
  outbound_rule { # All outbound
    protocol = "icmp"
    destination_addresses = ["0.0.0.0/0"]
  }
}

# Domains and DNS records
resource "digitalocean_domain" "domain" { 
  name = var.domain 
}

resource "digitalocean_record" "www_cname" {
  domain = digitalocean_domain.domain.name
  type   = "CNAME"
  name   = "www"
  value  = "@"
}

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