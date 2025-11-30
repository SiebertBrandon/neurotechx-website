output "namespace" {
  value       = kubernetes_namespace.monitoring.metadata[0].name
  description = "Monitoring namespace"
}

output "grafana_url" {
  value       = var.enable_grafana_ingress ? "https://${var.grafana_domain}" : null
  description = "Grafana URL if ingress is enabled"
}
