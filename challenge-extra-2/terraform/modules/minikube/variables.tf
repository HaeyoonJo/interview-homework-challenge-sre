variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "Kubeconfig context name for minikube"
  type        = string
  default     = "minikube"
}

variable "namespaces" {
  description = "List of namespaces to create"
  type        = list(string)
  default     = ["collector", "integration", "orcrist", "monitoring", "tools"]
}
