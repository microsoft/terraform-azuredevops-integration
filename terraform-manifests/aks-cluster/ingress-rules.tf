##############################################################################################################
# RESOURCES - (Ingress Rules)
##############################################################################################################
resource "kubernetes_ingress" "k8s_ingress_rules1" {
  wait_for_load_balancer = true
  metadata {
    name = "rm-ingress-rules"
    namespace = "rm-apis-ns"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx",
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod",
      "nginx.ingress.kubernetes.io/rewrite-target"= "/$1"
    }
  }
  spec {
    rule {
      host = "${azurerm_public_ip.k8s_ip.domain_name_label}.${var.aks_location}.cloudapp.azure.com"
      http {
        path {
          path = "/rm-customers-api/(.*)"
          backend {
            service_name = "rm-customers-api-service"
            service_port = 80
          }
        }
      }
    }

    tls {
        hosts = [ "${azurerm_public_ip.k8s_ip.domain_name_label}.${var.aks_location}.cloudapp.azure.com" ]
        secret_name = "gb-aks-secret-name"
    }
  }

  depends_on = [
    helm_release.ingress-nginx,
    helm_release.cert-manager,
    kubectl_manifest.cluster-issuer
  ]
}