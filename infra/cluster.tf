module "cluster" {
  source = "./modules/cluster"

  environment       = var.environment
  name              = var.cluster_name
  region            = var.region
  node_size         = var.cluster_node_size
  node_count        = var.cluster_node_count
  common_tags       = local.common_tags
}
