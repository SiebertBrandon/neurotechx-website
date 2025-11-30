variable "environment" {
  type        = string
  description = "Environment name: dev, staging, prod"
}

variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
  sensitive   = true
}

variable "project_name" {
  type        = string
  description = "Logical project name"
}

variable "region" {
  type        = string
  description = "DigitalOcean region slug"
}

variable "cluster_name" {
  type        = string
  description = "Kubernetes cluster name"
}

variable "cluster_node_size" {
  type        = string
  description = "Droplet size for Kubernetes nodes"
}

variable "cluster_node_count" {
  type        = number
  description = "Node count for primary node pool"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR range"
}

# Add others as needed (domain, TLS email, etc.)
