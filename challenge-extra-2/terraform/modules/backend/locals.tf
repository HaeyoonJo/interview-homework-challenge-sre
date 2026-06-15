locals {
  # Shared selector label used by the Deployment, its pod template, and the Service
  nginx_selector = {
    app = "nginx"
  }

  # Common labels applied to Deployment metadata
  nginx_labels = merge(local.nginx_selector, {
    managed-by = "terraform"
  })
}
