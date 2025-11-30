output "host" {
  value       = digitalocean_database_cluster.redis.host
  description = "Redis host"
}

output "port" {
  value       = digitalocean_database_cluster.redis.port
  description = "Redis port"
}

output "password" {
  value       = digitalocean_database_cluster.redis.password
  description = "Redis password"
  sensitive   = true
}

output "url" {
  value       = "redis://:${digitalocean_database_cluster.redis.password}@${digitalocean_database_cluster.redis.host}:${digitalocean_database_cluster.redis.port}"
  description = "Redis URL for apps"
  sensitive   = true
}
