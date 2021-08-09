# ##############################################################################################################
# # RESOURCES - (Helm)
# ##############################################################################################################
resource "helm_release" "ingress-nginx" {
    name        = "ingress-nginx"
    chart       = "ingress-nginx"
    repository  = "https://kubernetes.github.io/ingress-nginx"
    namespace   = kubernetes_namespace.ingress_namespace.metadata.0.name
   
    set {
      name  = "controller.service.loadBalancerIP"
      value = azurerm_public_ip.k8s_ip.ip_address
    }
    set {
      name  = "controller.replicaCount"
      value = var.ingress_replica_count
    }
    set {
        name = "controller.service.externalTrafficPolicy"
        value = "Local"
    }

    depends_on = [azurerm_public_ip.k8s_ip, azurerm_kubernetes_cluster.k8s]
}