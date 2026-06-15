output "deployment_name" {
  description = "Name of the nginx Deployment"
  value       = kubernetes_deployment.nginx.metadata[0].name
}

output "service_name" {
  description = "Name of the nginx Service"
  value       = kubernetes_service.nginx.metadata[0].name
}

output "pod_names" {
  description = "Names of all standalone pods"
  value = [
    kubernetes_pod.example_orcrist.metadata[0].name,
    kubernetes_pod.nginx_tools.metadata[0].name,
    kubernetes_pod.example_integration.metadata[0].name,
    kubernetes_pod.example_monitoring.metadata[0].name,
  ]
}
