terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.11.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11.0"
    }
  }
}

locals {
  release_name = "${var.name_prefix}-ingress"
}

resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace

    labels = merge(
      {
        "app.kubernetes.io/name"       = "ingress"
        "app.kubernetes.io/component"  = "controller"
        "app.kubernetes.io/managed-by" = "terraform"
        "app.kubernetes.io/part-of"    = "ingress"
        "app.kubernetes.io/env"        = var.environment
      },
      var.extra_labels
    )
  }
}

resource "helm_release" "ingress_nginx" {
  # Helm release details
  name       = local.release_name
  namespace  = var.namespace
  repository = var.repository
  chart      = var.chart_name
  version    = var.chart_version

  # Do not attempt to create the namespace via Helm
  create_namespace = false

  # Helm deployment options
  timeout = var.helm_timeout
  wait    = var.helm_wait
  atomic  = var.helm_atomic

  # Values to override in the Helm chart
  values = [
    yamlencode({
      controller = {
        # Enable/disable the controller
        replicaCount = var.controller_replica_count

        # IngressClass resource settings
        ingressClassResource = {
          enabled = var.ingress_class_resource_enabled
          name    = var.ingress_class_name
          default = var.ingress_class_resource_default
        }
        ingressClass        = var.ingress_class_name
        ingressClassByName  = var.ingress_class_by_name

        # Image settings
        service = {
          type                     = var.controller_service_type
          annotations              = var.controller_service_annotations
          externalTrafficPolicy    = var.controller_service_external_traffic_policy
          loadBalancerIP           = var.controller_service_load_balancer_ip
          loadBalancerSourceRanges = var.controller_service_lb_source_ranges
        }

        # NGINX configmap-like key/values
        config = var.controller_config

        # Extra CLI args to controller
        extraArgs = var.controller_extra_args

        # Extra env vars in controller pod
        extraEnv = var.controller_extra_env

        # Pod-level tuning
        podAnnotations     = var.controller_pod_annotations
        podLabels          = var.controller_pod_labels
        podSecurityContext = var.controller_pod_security_context
        priorityClassName  = var.priority_class_name

        # Scheduling
        nodeSelector = var.node_selector
        tolerations  = var.tolerations
        affinity     = var.affinity

        # Networking
        hostNetwork = var.controller_host_network
        dnsPolicy   = var.controller_dns_policy

        # ServiceAccount
        serviceAccount = {
          create      = var.controller_service_account_create
          name        = var.controller_service_account_name
          annotations = var.controller_service_account_annotations
        }

        # Scope to certain namespaces if desired
        scope = {
          enabled   = var.controller_scope_enabled
          namespace = var.controller_scope_namespace
        }

        # Metrics / Prometheus
        metrics = {
          enabled = var.controller_metrics_enabled

          serviceMonitor = {
            enabled          = var.controller_metrics_service_monitor_enabled
            additionalLabels = var.controller_metrics_service_monitor_labels
            namespace        = var.controller_metrics_service_monitor_namespace
          }

          annotations = var.controller_metrics_service_annotations
        }

        # Resource requests/limits
        resources = var.controller_resources
      }

      # Default backend settings
      defaultBackend = {
        enabled = var.default_backend_enabled
        image = {
          repository = var.default_backend_image_repository
          tag        = var.default_backend_image_tag
        }
        service = {
          type = var.default_backend_service_type
        }
      }
    })
  ]

  depends_on = [
    kubernetes_namespace.this
  ]
}
