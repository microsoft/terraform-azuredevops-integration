resource "helm_release" "cert-manager" {
    name        = "cert-manager"
    chart       = "cert-manager"
    repository  = "https://charts.jetstack.io"
    namespace   = kubernetes_namespace.ingress_namespace.metadata.0.name
    version     = var.cert-manager-version
     set {
      name  = "installCRDs"
      value = true
    }
    set {
      name = "ingressShim.defaultIssuerName"
      value = "letsencrypt-prod"
    }
    set {
      name = "ingressShim.defaultIssuerKind"
      value = "ClusterIssuer"
    }
   
    depends_on = [helm_release.ingress-nginx]
}
resource "kubectl_manifest" "cluster-issuer" {
    yaml_body = file("./kube-manifests/cluster-issuer.yaml")

    depends_on = [
      helm_release.cert-manager
    ]
}