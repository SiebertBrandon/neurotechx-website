module "cache" {
  source = "./modules/cache"

  environment = var.environment
  name_prefix = local.name_prefix
  size        = var.redis_size
  region      = var.region
  common_tags = local.common_tags
}
