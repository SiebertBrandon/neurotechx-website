resource "kubernetes_namespace" "monitoring" {
  metadata {
    name   = var.namespace
    labels = var.k8s_labels
  }
}

locals {
  grafana_values = var.enable_grafana_ingress ? {
    grafana = {
      ingress = {
        enabled = true
        ingressClassName = "nginx"
        hosts = [var.grafana_domain]
        tls = [{
          hosts      = [var.grafana_domain]
          secretName = "grafana-tls"
        }]
      }
    }
  } : {}
}

resource "helm_release" "kps" {
  name       = "${var.name_prefix}-kps"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.chart_version

  values = [
    yamlencode(merge(
      {
        prometheus = {
          prometheusSpec = {
            serviceMonitorSelector = {}
            podMonitorSelector     = {}
          }
        }
      },
      local.grafana_values
    ))
  ]
}
