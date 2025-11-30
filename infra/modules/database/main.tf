resource "digitalocean_database_cluster" "postgres" {
  name       = "${var.name_prefix}-pg"
  engine     = "pg"
  version    = var.engine_version
  region     = var.region
  size       = var.size
  node_count = 1
  tags       = [for k, v in var.common_tags : "${k}:${v}"]
}

resource "digitalocean_database_db" "app" {
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = "appdb"
}

resource "digitalocean_database_user" "app" {
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = "appuser"
}
