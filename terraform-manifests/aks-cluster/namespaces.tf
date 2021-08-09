##############################################################################################################
# RESOURCES - (Kubernetes namespaces)
# ##############################################################################################################
resource"kubernetes_namespace" "ingress_namespace" {
  metadata {
    name = "ingress-cert-ns"
  }
}

resource"kubernetes_namespace" "rm_apis_namespace" {
  metadata {
    name = "rm-apis-ns"
  }
}

