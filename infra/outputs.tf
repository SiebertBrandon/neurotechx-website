output "droplet_ip" {
  value = digitalocean_droplet.app.ipv4_address
}
output "droplet_id" {
  value = digitalocean_droplet.app.id
}
output "domain" {
  value = digitalocean_domain.domain.name
}
output "ssh_key_fingerprint" {
  value = data.digitalocean_ssh_key.me.fingerprint
}
output "ssh_key_id" {
  value = data.digitalocean_ssh_key.me.id
}
output "ssh_key_name" {
  value = data.digitalocean_ssh_key.me.name
}
output "firewall_id" {
  value = digitalocean_firewall.fw.id
}
output "droplet_name" {
  value = digitalocean_droplet.app.name
}
output "droplet_region" {
  value = digitalocean_droplet.app.region
}
output "droplet_size" {
  value = digitalocean_droplet.app.size
}
output "droplet_image" {
  value = digitalocean_droplet.app.image
}
output "droplet_status" {
  value = digitalocean_droplet.app.status
}
output "droplet_created_at" {
  value = digitalocean_droplet.app.created_at
}
output "droplet_ipv6" {
  value = digitalocean_droplet.app.ipv6
}
output "droplet_private_networking" {
  value = digitalocean_droplet.app.private_networking
}
output "droplet_monitoring" {
  value = digitalocean_droplet.app.monitoring
}
output "droplet_tags" {
  value = digitalocean_droplet.app.tags
}
output "droplet_vpc_uuid" {
  value = digitalocean_droplet.app.vpc_uuid
}
output "droplet_user_data" {
  value = digitalocean_droplet.app.user_data
}
output "droplet_backup_ids" {
  value = digitalocean_droplet.app.backup_ids
}
output "droplet_snapshot_ids" {
  value = digitalocean_droplet.app.snapshot_ids
}
output "droplet_disk" {
  value = digitalocean_droplet.app.disk
}
output "droplet_kernel_id" {
  value = digitalocean_droplet.app.kernel_id
}
output "droplet_locked" {
  value = digitalocean_droplet.app.locked
}
output "droplet_next_backup_window" {
  value = digitalocean_droplet.app.next_backup_window
}
output "droplet_ipv4_address" {
  value = digitalocean_droplet.app.ipv4_address
}
output "droplet_ipv4_netmask" {
  value = digitalocean_droplet.app.ipv4_netmask
}
output "droplet_ipv4_gateway" {
  value = digitalocean_droplet.app.ipv4_gateway
}
output "droplet_image_slug" {
  value = digitalocean_droplet.app.image_slug
}
output "droplet_size_slug" {
  value = digitalocean_droplet.app.size_slug
}
output "droplet_region_slug" {
  value = digitalocean_droplet.app.region_slug
}
output "droplet_firewall_ids" {
  value = digitalocean_droplet.app.firewall_ids
}
