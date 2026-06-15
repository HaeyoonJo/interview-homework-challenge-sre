resource "kubernetes_pod" "example_orcrist" {
  metadata {
    name      = "pod-example-orcrist"
    namespace = var.pod_orcrist_namespace
  }

  spec {
    container {
      name  = "pod"
      image = "alpine"
      args  = ["cat"]
      tty   = true
      stdin = true
    }
  }
}

resource "kubernetes_pod" "nginx_tools" {
  metadata {
    name      = "pod-nginx-tools"
    namespace = var.pod_tools_namespace
  }

  spec {
    container {
      name  = "pod"
      image = "nginx"

      port {
        name           = "web"
        container_port = 80
        protocol       = "TCP"
      }
    }
  }
}

resource "kubernetes_pod" "example_integration" {
  metadata {
    name      = "pod-example-integration"
    namespace = var.pod_integration_namespace
  }

  spec {
    container {
      name  = "pod"
      image = "alpine"
      args  = ["cat"]
      tty   = true
      stdin = true
    }
  }
}

resource "kubernetes_pod" "example_monitoring" {
  metadata {
    name      = "pod-example-monitoring"
    namespace = var.pod_monitoring_namespace
  }

  spec {
    container {
      name  = "pod"
      image = "alpine"
      args  = ["cat"]
      tty   = true
      stdin = true
    }
  }
}
