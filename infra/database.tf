module "database" {
  source = "./modules/database"

  environment  = var.environment
  name_prefix  = local.name_prefix
  size         = var.postgres_size
  region       = var.region
  common_tags  = local.common_tags
}
