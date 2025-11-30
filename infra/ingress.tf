module "ingress_nginx" {
  source       = "./modules/ingress_nginx"
  environment  = var.environment
  name_prefix  = local.name_prefix
  namespace    = "ingress-nginx"

  # override defaults as needed per env
  controller_replica_count = 1
  controller_service_type  = "LoadBalancer"
}
