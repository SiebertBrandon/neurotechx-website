module "monitoring" {
  source = "./modules/monitoring"

  environment       = var.environment
  name_prefix       = local.name_prefix
  k8s_labels        = local.k8s_labels
  grafana_domain    = "grafana.${var.domain_root}"
  enable_grafana_ingress = true
}
