module "network" {
  source = "./modules/network"

  environment = var.environment
  project     = var.project_name
  region      = var.region
  vpc_cidr    = var.vpc_cidr
  common_tags = local.common_tags
}
