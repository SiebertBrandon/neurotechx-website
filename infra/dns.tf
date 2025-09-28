# Create the zone in DigitalOcean DNS
resource "digitalocean_domain" "root" {
  name       = var.domain
  ip_address = digitalocean_droplet.app.ipv4_address
}

resource "digitalocean_record" "www_cname" {
  domain = digitalocean_domain.domain.name
  type   = "CNAME"
  name   = "www"
  value  = "@"
}

resource "digitalocean_record" "root_a" {
  domain = digitalocean_domain.root.name
  type   = "A"
  name   = "@"
  value  = digitalocean_droplet.app.ipv4_address
  ttl    = 300
}

resource "digitalocean_record" "root_aaaa" {
  domain = digitalocean_domain.root.name
  type   = "AAAA"
  name   = "@"
  value  = digitalocean_droplet.app.ipv6_address
  ttl    = 300
}

locals {
  cname_hosts = ["www", "api", "grafana", "prometheus", "traefik"]
}

resource "digitalocean_record" "aliases" {
  for_each = toset(local.cname_hosts)
  domain   = digitalocean_domain.root.name
  type     = "CNAME"
  name     = each.value
  value    = "@"
  ttl      = 300
}
