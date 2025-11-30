variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, staging, prod)."
}

variable "name_prefix" {
  type        = string
  description = "Prefix for naming the Helm release (e.g. project-env)."
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace where ingress-nginx will be installed."
  default     = "ingress-nginx"
}

variable "create_namespace" {
  type        = bool
  description = "Whether to create the namespace for ingress-nginx."
  default     = true
}

variable "repository" {
  type        = string
  description = "Helm repository URL for ingress-nginx."
  default     = "https://kubernetes.github.io/ingress-nginx"
}

variable "chart_name" {
  type        = string
  description = "Helm chart name for ingress-nginx."
  default     = "ingress-nginx"
}

variable "chart_version" {
  type        = string
  description = "Helm chart version for ingress-nginx."
  # Latest as of the time of writing – pin in real setups.
  default     = "4.14.0"
}

variable "helm_timeout" {
  type        = number
  description = "Helm install/upgrade timeout in seconds."
  default     = 600
}

variable "helm_wait" {
  type        = bool
  description = "Whether to wait for resources to become ready."
  default     = true
}

variable "helm_atomic" {
  type        = bool
  description = "Rollback changes if Helm upgrade fails."
  default     = true
}

variable "extra_labels" {
  type        = map(string)
  description = "Extra labels applied to the namespace."
  default     = {}
}

# ─────────────────────────────────────────────────────────────
# IngressClass / controller basics
# ─────────────────────────────────────────────────────────────

variable "ingress_class_name" {
  type        = string
  description = "IngressClass name used by this controller."
  default     = "nginx"
}

variable "ingress_class_by_name" {
  type        = bool
  description = "Use IngressClass by name instead of annotation."
  default     = true
}

variable "ingress_class_resource_enabled" {
  type        = bool
  description = "Create an IngressClass resource."
  default     = true
}

variable "ingress_class_resource_default" {
  type        = bool
  description = "Mark this IngressClass as the default."
  default     = false
}

variable "controller_replica_count" {
  type        = number
  description = "Number of controller replicas."
  default     = 2
}

# ─────────────────────────────────────────────────────────────
# Service / load balancer
# ─────────────────────────────────────────────────────────────

variable "controller_service_type" {
  type        = string
  description = "Service type for the controller (ClusterIP, NodePort, LoadBalancer)."
  default     = "LoadBalancer"
}

variable "controller_service_annotations" {
  type        = map(string)
  description = "Annotations for the controller Service."
  default     = {}
}

variable "controller_service_external_traffic_policy" {
  type        = string
  description = "External traffic policy (Cluster or Local)."
  default     = "Local"
}

variable "controller_service_load_balancer_ip" {
  type        = string
  description = "Optional static LoadBalancer IP."
  default     = ""
}

variable "controller_service_lb_source_ranges" {
  type        = list(string)
  description = "Allowed source ranges for the LoadBalancer."
  default     = []
}

# ─────────────────────────────────────────────────────────────
# NGINX configuration / behavior
# ─────────────────────────────────────────────────────────────

variable "controller_config" {
  type        = map(string)
  description = "Key/value pairs for nginx configuration (maps to controller.config)."
  default     = {}
}

variable "controller_extra_args" {
  type        = map(string)
  description = "Extra CLI arguments for the controller."
  default     = {}
}

variable "controller_extra_env" {
  description = "Extra environment variables for the controller pod."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

# ─────────────────────────────────────────────────────────────
# Pod / scheduling
# ─────────────────────────────────────────────────────────────

variable "controller_pod_annotations" {
  type        = map(string)
  description = "Pod annotations for the controller."
  default     = {}
}

variable "controller_pod_labels" {
  type        = map(string)
  description = "Additional pod labels for the controller."
  default     = {}
}

variable "controller_pod_security_context" {
  description = "Pod security context for the controller."
  type        = map(any)
  default     = {}
}

variable "priority_class_name" {
  type        = string
  description = "PriorityClass name for the controller pods."
  default     = ""
}

variable "node_selector" {
  type        = map(string)
  description = "Node selector for scheduling controller pods."
  default     = {}
}

variable "tolerations" {
  description = "Tolerations for controller pods."
  type        = list(map(any))
  default     = []
}

variable "affinity" {
  description = "Affinity rules for controller pods."
  type        = map(any)
  default     = {}
}

variable "controller_host_network" {
  type        = bool
  description = "Run controller pods on the host network."
  default     = false
}

variable "controller_dns_policy" {
  type        = string
  description = "DNS policy for controller pods."
  default     = "ClusterFirst"
}

# ─────────────────────────────────────────────────────────────
# ServiceAccount
# ─────────────────────────────────────────────────────────────

variable "controller_service_account_create" {
  type        = bool
  description = "Create a ServiceAccount for the controller."
  default     = true
}

variable "controller_service_account_name" {
  type        = string
  description = "Name of the ServiceAccount for the controller (empty to auto-generate)."
  default     = ""
}

variable "controller_service_account_annotations" {
  type        = map(string)
  description = "Annotations for the controller ServiceAccount."
  default     = {}
}

# ─────────────────────────────────────────────────────────────
# Namespace scoping
# ─────────────────────────────────────────────────────────────

variable "controller_scope_enabled" {
  type        = bool
  description = "Limit controller to specific namespaces."
  default     = false
}

variable "controller_scope_namespace" {
  type        = string
  description = "Namespace (or comma-separated list) the controller watches when scoped."
  default     = ""
}

# ─────────────────────────────────────────────────────────────
# Metrics / Prometheus
# ─────────────────────────────────────────────────────────────

variable "controller_metrics_enabled" {
  type        = bool
  description = "Expose metrics endpoint for the controller."
  default     = true
}

variable "controller_metrics_service_monitor_enabled" {
  type        = bool
  description = "Create a ServiceMonitor resource (for Prometheus Operator)."
  default     = false
}

variable "controller_metrics_service_monitor_labels" {
  type        = map(string)
  description = "Additional labels for the ServiceMonitor."
  default     = {}
}

variable "controller_metrics_service_monitor_namespace" {
  type        = string
  description = "Namespace in which to create the ServiceMonitor (empty = same as release)."
  default     = ""
}

variable "controller_metrics_service_annotations" {
  type        = map(string)
  description = "Annotations on the metrics Service."
  default     = {}
}

variable "controller_resources" {
  description = "Resource requests and limits for the controller pods."
  type        = map(any)
  default     = {}
}

# ─────────────────────────────────────────────────────────────
# Default backend
# ─────────────────────────────────────────────────────────────

variable "default_backend_enabled" {
  type        = bool
  description = "Deploy the default backend that serves 404s for unmatched hosts/paths."
  default     = true
}

variable "default_backend_image_repository" {
  type        = string
  description = "Image repository for the default backend."
  default     = "k8s.gcr.io/defaultbackend-amd64"
}

variable "default_backend_image_tag" {
  type        = string
  description = "Image tag for the default backend."
  default     = "1.5"
}

variable "default_backend_service_type" {
  type        = string
  description = "Service type for the default backend."
  default     = "ClusterIP"
}
