output "release_name" {
  value       = helm_release.app.name
  description = "App Helm release name"
}

output "namespace" {
  value       = var.namespace
  description = "Deployment namespace"
}
