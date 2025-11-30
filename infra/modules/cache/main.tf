resource "digitalocean_database_cluster" "redis" {
  name       = "${var.name_prefix}-redis"
  engine     = "redis"
  version    = "7"
  region     = var.region
  size       = var.size
  node_count = 1
  tags       = [for k, v in var.common_tags : "${k}:${v}"]
}
