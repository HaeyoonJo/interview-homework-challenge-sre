locals {
  nginx_selector = {
    app = "nginx"
  }

  nginx_labels = merge(local.nginx_selector, {
    managed-by = "terraform"
  })
}
