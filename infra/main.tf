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

locals {
  docker_image = var.app_image
  # Load env vars from files
  envs = { for tuple in regexall("(.*)=(.*)", file(".infra.env")) : tuple[0] => tuple[1] }
  creds = { for tuple in regexall("(.*)=(.*)", file(".infra.creds.env")) : tuple[0] => sensitive(tuple[1]) }
}

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
  region = var.region
  size   = var.size
  image  = var.os_image
  backups = var.enable_backups
  ssh_keys = [for k in data.digitalocean_ssh_keys.team.keys : k.id]
  user_data = data.template_file.cloud_init.rendered
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

