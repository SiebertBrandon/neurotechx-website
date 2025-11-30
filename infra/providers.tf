provider "digitalocean" {
  token = var.do_token
}

# These depend on the DO cluster module outputs;
# later, if you migrate to another provider, you'll only
# change the cluster module implementation and here.
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
