variable "environment" {
  type        = string
  description = "Environment name"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for Helm release"
}

variable "namespace" {
  type        = string
  default     = "monitoring"
  description = "Monitoring namespace"
}

variable "k8s_labels" {
  type        = map(string)
  default     = {}
  description = "Labels for namespace/resources"
}

variable "grafana_domain" {
  type        = string
  description = "FQDN for accessing Grafana"
}

variable "enable_grafana_ingress" {
  type        = bool
  default     = true
  description = "Expose Grafana via ingress"
}

variable "chart_version" {
  type        = string
  default     = "65.0.0" # example
  description = "kube-prometheus-stack chart version"
}
