resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-deployment"
    namespace = var.nginx_namespace
    labels    = local.nginx_labels
  }

  spec {
    replicas = var.nginx_replicas

    selector {
      match_labels = local.nginx_selector
    }

    template {
      metadata {
        labels = local.nginx_selector
      }

      spec {
        container {
          name  = "nginx"
          image = var.nginx_image

          port {
            container_port = 80
          }
        }
      }
    }
  }
}
