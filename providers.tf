# Minikube provider configuration
provider "minikube" {
  kubernetes_version = "v1.30.0"
}

# Kubernetes provider configuration
# For CI/CD: This will be skipped when create_k8s_resources = false
# For local development: Uses kubectl config to connect to existing cluster
provider "kubernetes" {
  # Use default kubectl config when creating resources
  # Skip cluster connection when create_k8s_resources = false for CI/CD validation
  config_path = var.create_k8s_resources ? "~/.kube/config" : null
  config_context = var.create_k8s_resources ? "devops-project" : null
  
  # Ignore missing context during initial plan
  ignore_annotations = []
}

# Helm provider configuration
provider "helm" {
  kubernetes {
    config_path = var.create_k8s_resources ? "~/.kube/config" : null
    config_context = var.create_k8s_resources ? "devops-project" : null
  }
}