output "host" {
  value       = digitalocean_database_cluster.postgres.host
  description = "Postgres host"
}

output "port" {
  value       = digitalocean_database_cluster.postgres.port
  description = "Postgres port"
}

output "database" {
  value       = digitalocean_database_db.app.name
  description = "Database name"
}

output "username" {
  value       = digitalocean_database_user.app.name
  description = "Database user"
}

output "password" {
  value       = digitalocean_database_user.app.password
  description = "Database password"
  sensitive   = true
}

output "app_dsn" {
  value       = "postgresql://${digitalocean_database_user.app.name}:${digitalocean_database_user.app.password}@${digitalocean_database_cluster.postgres.host}:${digitalocean_database_cluster.postgres.port}/${digitalocean_database_db.app.name}?sslmode=require"
  description = "Connection string for apps (include sslmode=require)"
  sensitive   = true
}
