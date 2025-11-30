module "jobboard_namespace" {
  source = "./modules/namespace"
  name   = "ntx-jobboard"
  labels = local.k8s_labels
}

module "jobboard_api" {
  source = "./modules/app_helm_release"

  namespace        = module.jobboard_namespace.name
  release_name     = "${local.name_prefix}-jobboard"
  chart            = "oci://ghcr.io/your-org/helm-charts/jobboard-api"
  chart_version    = "1.0.0"
  image_repository = "ghcr.io/your-org/jobboard-api"
  image_tag        = "latest"

  env = {
    ENVIRONMENT  = var.environment
    POSTGRES_DSN = module.postgres.app_dsn
    CACHE_URL    = module.cache.url
  }

  ingress = {
    enabled   = true
    host      = var.domain_api
    path      = "/jobs"
    tls       = true
    class_name = "nginx"
  }

  resources = {
    requests = {
      cpu    = "100m"
      memory = "128Mi"
    }
    limits = {
      cpu    = "500m"
      memory = "512Mi"
    }
  }

  labels = local.k8s_labels
}
