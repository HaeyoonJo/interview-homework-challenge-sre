output "namespaces" {
  description = "All provisioned namespaces"
  value       = module.namespaces.namespace_names
}

output "deployment_name" {
  description = "nginx Deployment name"
  value       = module.backend.deployment_name
}

output "service_name" {
  description = "nginx Service name"
  value       = module.backend.service_name
}

output "pod_names" {
  description = "All standalone pod names"
  value       = module.backend.pod_names
}
