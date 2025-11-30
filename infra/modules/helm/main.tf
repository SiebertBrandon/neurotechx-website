locals {
  base_values = {
    image = {
      repository = var.image_repository
      tag        = var.image_tag
    }
    replicaCount = var.replicas
    env = [
      for k, v in var.env : {
        name  = k
        value = v
      }
    ]
    resources = var.resources
    labels    = var.labels
    ingress = {
      enabled = var.ingress.enabled
      className = var.ingress.class_name
      hosts = [
        {
          host  = var.ingress.host
          paths = [
            {
              path     = var.ingress.path
              pathType = "Prefix"
            }
          ]
        }
      ]
      tls = var.ingress.tls ? [
        {
          hosts      = [var.ingress.host]
          secretName = "${var.release_name}-tls"
        }
      ] : []
    }
  }
}

resource "helm_release" "app" {
  name       = var.release_name
  namespace  = var.namespace
  chart      = var.chart
  version    = var.chart_version

  # Merge base values with any extra_values
  values = [
    yamlencode(merge(local.base_values, var.extra_values))
  ]
}
