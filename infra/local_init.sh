set -a && source local.creds.env && set +a
terraform init -backend-config=backend.hcl -reconfigure
