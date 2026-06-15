resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx-service"
    namespace = var.nginx_namespace
  }

  spec {
    selector = local.nginx_selector

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }

    type = var.nginx_service_type
  }
}
