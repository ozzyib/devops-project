# Kubernetes provider configuration
# For CI/CD: This will be skipped when create_k8s_resources = false
# For local development: Configure this to point to your local cluster
provider "kubernetes" {
  # Only configure if we're actually creating resources
  # In CI/CD, validation will work without cluster connection
  config_path = var.create_k8s_resources ? "~/.kube/config" : null
}