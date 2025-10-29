provider "kubernetes" {
  host                   = minikube_cluster.minikube_docker.host
  client_certificate     = minikube_cluster.minikube_docker.client_certificate
  client_key             = minikube_cluster.minikube_docker.client_key
  cluster_ca_certificate = minikube_cluster.minikube_docker.cluster_ca_certificate
}