output "namespace" {
  description = "Namespace where ingress-nginx is installed."
  value       = var.namespace
}

output "release_name" {
  description = "Helm release name for the ingress-nginx controller."
  value       = helm_release.ingress_nginx.name
}

output "chart_version" {
  description = "Deployed Helm chart version."
  value       = helm_release.ingress_nginx.version
}

output "ingress_class_name" {
  description = "IngressClass name used by this controller."
  value       = var.ingress_class_name
}

output "service_type" {
  description = "Service type for the controller Service."
  value       = var.controller_service_type
}

output "load_balancer_ip" {
  description = "Requested LoadBalancer IP (if any)."
  value       = var.controller_service_load_balancer_ip
}
