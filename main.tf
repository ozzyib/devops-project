terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
  }
}

# This is a sample Kubernetes configuration that can be validated in CI
# For local development, you can still use minikube separately
resource "kubernetes_namespace" "devops_app" {
  count = var.create_k8s_resources ? 1 : 0
  
  metadata {
    name = "devops-app"
    labels = {
      environment = var.environment
      app         = "devops-project"
    }
  }
}

resource "kubernetes_deployment" "flask_app" {
  count = var.create_k8s_resources ? 1 : 0
  
  metadata {
    name      = "flask-app"
    namespace = kubernetes_namespace.devops_app[0].metadata[0].name
    labels = {
      app = "flask-app"
    }
  }

  spec {
    replicas = var.app_replicas

    selector {
      match_labels = {
        app = "flask-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "flask-app"
        }
      }

      spec {
        container {
          image = "${var.docker_image}:${var.image_tag}"
          name  = "flask-app"
          
          port {
            container_port = 8080
          }

          env {
            name  = "ENVIRONMENT"
            value = var.environment
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "flask_app" {
  count = var.create_k8s_resources ? 1 : 0
  
  metadata {
    name      = "flask-app-service"
    namespace = kubernetes_namespace.devops_app[0].metadata[0].name
  }

  spec {
    selector = {
      app = "flask-app"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}

# Output some useful information
output "namespace_name" {
  description = "The name of the created Kubernetes namespace"
  value       = var.create_k8s_resources ? kubernetes_namespace.devops_app[0].metadata[0].name : "Not created (create_k8s_resources = false)"
}

output "deployment_name" {
  description = "The name of the created Kubernetes deployment"
  value       = var.create_k8s_resources ? kubernetes_deployment.flask_app[0].metadata[0].name : "Not created (create_k8s_resources = false)"
}
