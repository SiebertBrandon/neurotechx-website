endpoints = {
  s3 = "https://sfo3.digitaloceanspaces.com"
}

region                      = "us-east-1"
bucket                      = "ntx-tf-state"
key                         = "terraform/state/do-droplet.tfstate"
use_path_style              = true
skip_credentials_validation = true
skip_region_validation      = true
skip_requesting_account_id  = true
