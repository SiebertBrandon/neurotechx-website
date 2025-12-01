provider "digitalocean" {
  token = var.do_token
}

provider "kubernetes" {
  host                   = module.cluster.kube_host
  token                  = module.cluster.kube_token
  cluster_ca_certificate = module.cluster.kube_ca_cert
}

provider "helm" {
  kubernetes {
    host                   = module.cluster.kube_host
    token                  = module.cluster.kube_token
    cluster_ca_certificate = module.cluster.kube_ca_cert
  }
}
