environment         = "dev"
project_name        = "my-platform"
region              = "nyc3"

cluster_name        = "my-platform-dev"
cluster_node_size   = "s-2vcpu-4gb"
cluster_node_count  = 2

vpc_cidr            = "10.10.0.0/16"

domain_root         = "example.dev"
domain_website      = "www.example.dev"
domain_api          = "api.example.dev"

postgres_size       = "db-s-1vcpu-1gb"
redis_size          = "db-s-1vcpu-1gb"

enable_github_runner = true

github_org   = "my-org"
github_repo  = "my-repo"
