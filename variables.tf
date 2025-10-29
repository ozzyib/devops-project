variable "environment" {
  description = "The environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "create_k8s_resources" {
  description = "Whether to create Kubernetes resources (set to false for CI/CD validation)"
  type        = bool
  default     = false
}

variable "app_replicas" {
  description = "Number of replicas for the Flask application"
  type        = number
  default     = 2
}

variable "docker_image" {
  description = "Docker image name for the Flask application"
  type        = string
  default     = "ozzyi/devops-project"
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}