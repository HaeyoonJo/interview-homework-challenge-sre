variable "nginx_namespace" {
  description = "Namespace to deploy nginx into"
  type        = string
  default     = "orcrist"
}

variable "nginx_replicas" {
  description = "Number of nginx pod replicas"
  type        = number
  default     = 3
}

variable "nginx_image" {
  description = "nginx container image"
  type        = string
  default     = "nginx:latest"
}

variable "nginx_service_type" {
  description = "Kubernetes Service type (ClusterIP, NodePort, LoadBalancer)"
  type        = string
  default     = "ClusterIP"
}

variable "pod_orcrist_namespace" {
  description = "Namespace for the orcrist example pod"
  type        = string
  default     = "orcrist"
}

variable "pod_tools_namespace" {
  description = "Namespace for the tools nginx pod"
  type        = string
  default     = "tools"
}

variable "pod_integration_namespace" {
  description = "Namespace for the integration example pod"
  type        = string
  default     = "integration"
}

variable "pod_monitoring_namespace" {
  description = "Namespace for the monitoring example pod"
  type        = string
  default     = "monitoring"
}
