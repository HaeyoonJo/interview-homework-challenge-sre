variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "kube_context" {
  description = "Kubeconfig context to use"
  type        = string
  default     = "minikube"
}

variable "nginx_image" {
  description = "nginx container image"
  type        = string
  default     = "nginx:latest"
}

variable "nginx_replicas" {
  description = "Number of nginx replicas"
  type        = number
  default     = 1
}

variable "nginx_service_type" {
  description = "Kubernetes Service type for nginx"
  type        = string
  default     = "ClusterIP"
}
