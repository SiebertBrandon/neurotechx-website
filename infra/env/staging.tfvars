environment         = "dev"
project_name        = "ntx-web-platform-dev"
region              = "nyc"

cluster_name        = "ntx-web-platform-dev"
cluster_node_size   = "s-2vcpu-4gb"
cluster_node_count  = 1

vpc_cidr            = "10.10.0.0/16"

domain_root         = "staging.neurotechx.xyz"
domain_website      = "www.staging.neurotechx.xyz"
domain_api          = "api.staging.neurotechx.xyz"

postgres_size       = "db-s-1vcpu-1gb"
redis_size          = "db-s-1vcpu-1gb"

enable_github_runner = true

github_org   = "SiebertBrandon"
github_repo  = "neurotechx-website"
