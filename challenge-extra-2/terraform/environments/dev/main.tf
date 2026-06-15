terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
  }
  required_version = ">= 1.3.0"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.kube_context
}

# ── Namespaces ────────────────────────────────────────────────────────────────

module "namespace_collector" {
  source = "../../modules/namespaces"
  name   = "collector"
  labels = { environment = var.environment }
}

module "namespace_integration" {
  source = "../../modules/namespaces"
  name   = "integration"
  labels = { environment = var.environment }
}

module "namespace_orcrist" {
  source = "../../modules/namespaces"
  name   = "orcrist"
  labels = { environment = var.environment }
}

module "namespace_monitoring" {
  source = "../../modules/namespaces"
  name   = "monitoring"
  labels = { environment = var.environment }
}

module "namespace_tools" {
  source = "../../modules/namespaces"
  name   = "tools"
  labels = { environment = var.environment }
}

# ── Deployment + Service ──────────────────────────────────────────────────────

module "nginx" {
  source = "../../modules/deployment"

  name            = "nginx-deployment"
  namespace       = module.namespace_orcrist.name
  labels          = { app = "nginx" }
  replicas        = var.nginx_replicas
  selector_labels = { app = "nginx" }
  container_name  = "nginx"
  image           = var.nginx_image
  ports           = [80]

  service_name  = "nginx-service"
  service_type  = var.nginx_service_type
  service_ports = [{ protocol = "TCP", port = 80, target_port = 80 }]
}

# ── Pods ──────────────────────────────────────────────────────────────────────

module "pod_example_orcrist" {
  source    = "../../modules/pod"
  name      = "pod-example-orcrist"
  namespace = module.namespace_orcrist.name
  image     = "alpine"
  args      = ["cat"]
  tty       = true
  stdin     = true
}

module "pod_nginx_tools" {
  source    = "../../modules/pod"
  name      = "pod-nginx-tools"
  namespace = module.namespace_tools.name
  image     = "nginx"
  ports     = [{ name = "web", container_port = 80, protocol = "TCP" }]
}

module "pod_example_integration" {
  source    = "../../modules/pod"
  name      = "pod-example-integration"
  namespace = module.namespace_integration.name
  image     = "alpine"
  args      = ["cat"]
  tty       = true
  stdin     = true
}

module "pod_example_monitoring" {
  source    = "../../modules/pod"
  name      = "pod-example-monitoring"
  namespace = module.namespace_monitoring.name
  image     = "alpine"
  args      = ["cat"]
  tty       = true
  stdin     = true
}
