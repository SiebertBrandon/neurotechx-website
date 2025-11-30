module "github_runner" {
  source = "./modules/github_runner"

  environment    = var.environment
  name_prefix    = local.name_prefix
  enable         = var.enable_github_runner
  github_org     = var.github_org
  github_repo    = var.github_repo
  github_token   = var.github_token
  labels         = ["k8s", var.environment]
}
