output "namespace" {
  value       = var.enable ? var.namespace : null
  description = "Namespace where runners are deployed"
}

output "enabled" {
  value       = var.enable
  description = "Whether runner module is enabled"
}
