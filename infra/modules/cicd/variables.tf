variable "environment" {
  type        = string
  description = "Environment name"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for resources"
}

variable "enable" {
  type        = bool
  default     = true
  description = "Whether to deploy runner"
}

variable "namespace" {
  type        = string
  default     = "github-runners"
  description = "Namespace for runner controller"
}

variable "github_org" {
  type        = string
  description = "GitHub org (or user) name"
}

variable "github_repo" {
  type        = string
  default     = ""
  description = "Optional repo name; empty to scope to org"
}

variable "github_token" {
  type        = string
  description = "GitHub PAT for registering runners"
  sensitive   = true
}

variable "labels" {
  type        = list(string)
  default     = []
  description = "Runner labels"
}

variable "chart_version" {
  type        = string
  default     = "0.24.1" # example for actions-runner-controller
  description = "Chart version"
}
