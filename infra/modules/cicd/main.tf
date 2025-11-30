locals {
  target_repo = var.github_repo != "" ? "${var.github_org}/${var.github_repo}" : var.github_org
}

resource "kubernetes_namespace" "runners" {
  count = var.enable ? 1 : 0

  metadata {
    name = var.namespace
  }
}

resource "kubernetes_secret" "github_token" {
  count = var.enable ? 1 : 0

  metadata {
    name      = "github-token"
    namespace = kubernetes_namespace.runners[0].metadata[0].name
  }

  data = {
    token = base64encode(var.github_token)
  }

  type = "Opaque"
}

resource "helm_release" "arc" {
  count = var.enable ? 1 : 0

  name       = "${var.name_prefix}-arc"
  namespace  = kubernetes_namespace.runners[0].metadata[0].name
  repository = "https://actions-runner-controller.github.io/actions-runner-controller"
  chart      = "actions-runner-controller"
  version    = var.chart_version

  values = [
    yamlencode({
      githubConfigSecret = "github-token"
      authSecret = {
        create = false
        name   = "github-token"
      }
    })
  ]
}

# Example RunnerDeployment CR via kubernetes_manifest (requires provider >= 2.30.0)
resource "kubernetes_manifest" "runner_deployment" {
  count = var.enable ? 1 : 0

  manifest = {
    apiVersion = "actions.github.com/v1alpha1"
    kind       = "RunnerDeployment"
    metadata = {
      name      = "${var.name_prefix}-runner"
      namespace = kubernetes_namespace.runners[0].metadata[0].name
    }
    spec = {
      replicas = 1
      template = {
        spec = {
          repository = var.github_repo != "" ? local.target_repo : null
          organization = var.github_repo == "" ? var.github_org : null
          labels = var.labels
        }
      }
    }
  }

  depends_on = [helm_release.arc]
}
