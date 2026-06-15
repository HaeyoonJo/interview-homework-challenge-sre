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
  config_context = "minikube"
}

module "namespaces" {
  source     = "./modules/namespaces"
  namespaces = ["collector", "integration", "orcrist", "monitoring", "tools"]
}

module "backend" {
  source     = "./modules/backend"
  depends_on = [module.namespaces]
}
