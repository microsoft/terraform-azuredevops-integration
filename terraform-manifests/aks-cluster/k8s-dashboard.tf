 ##############################################################################################################

# # RESOURCES - Kubernet-Dashboard (Helm)

# ##############################################################################################################

resource "helm_release" "kubernetes-dashboard" {
  name       = "my-release"
  version    = "4.0.3"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
}