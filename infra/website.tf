module "website_namespace" {
  source = "./modules/namespace"

  name       = "website"
  labels     = local.k8s_labels
}

module "website_app" {
  source = "./modules/helm"

  namespace         = module.website_namespace.name
  release_name      = "${local.name_prefix}-website"
  chart             = "oci://ghcr.io/your-org/helm-charts/website"
  chart_version     = "1.0.0"
  image_repository  = "ghcr.io/your-org/website"
  image_tag         = "latest" # or from CI
  replicas          = 2

  env = {
    ENVIRONMENT      = var.environment
    POSTGRES_DSN     = module.database.app_dsn
    CACHE_URL        = module.cache.url
  }

  ingress = {
    enabled   = true
    host      = var.domain_website
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
