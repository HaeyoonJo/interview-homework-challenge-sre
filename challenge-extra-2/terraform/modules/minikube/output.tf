output "namespaces" {
  description = "Namespaces created by the namespaces module"
  value       = module.namespaces.namespace_names
}

output "backend_deployment" {
  description = "nginx Deployment name"
  value       = module.backend.deployment_name
}

output "backend_service" {
  description = "nginx Service name"
  value       = module.backend.service_name
}

output "backend_pods" {
  description = "Pod names created by the backend module"
  value       = module.backend.pod_names
}
