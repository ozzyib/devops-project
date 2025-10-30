resource "helm_release" "argocd" {
  count = var.create_k8s_resources ? 1 : 0

  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = kubernetes_namespace.argocd[0].metadata[0].name
  version    = "9.0.5"

  values = [
    <<EOF
    server:
      service:
        type: ClusterIP
    EOF
  ]

  depends_on = [kubernetes_namespace.argocd]
}