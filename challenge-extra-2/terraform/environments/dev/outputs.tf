output "namespaces" {
  description = "Provisioned namespaces"
  value = [
    module.namespace_collector.name,
    module.namespace_integration.name,
    module.namespace_orcrist.name,
    module.namespace_monitoring.name,
    module.namespace_tools.name,
  ]
}

output "nginx_deployment" {
  description = "nginx Deployment name"
  value       = module.nginx.deployment_name
}

output "nginx_service" {
  description = "nginx Service name"
  value       = module.nginx.service_name
}

output "pods" {
  description = "Provisioned pods"
  value = [
    module.pod_example_orcrist.name,
    module.pod_nginx_tools.name,
    module.pod_example_integration.name,
    module.pod_example_monitoring.name,
  ]
}
