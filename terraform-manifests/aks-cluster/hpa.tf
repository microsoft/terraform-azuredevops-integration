# ##############################################################################################################
# # RESOURCES - (Horizontal Pod Autoscaler)
# ##############################################################################################################

resource "kubernetes_horizontal_pod_autoscaler" "hpa_rm_customers_api_deployment" {
  metadata {
    name = "hpa-${var.rm-customers-api-deployment}"
    namespace = kubernetes_namespace.rm_apis_namespace.metadata.0.name
  }
  spec {
    max_replicas = 10
    min_replicas = 2

    target_cpu_utilization_percentage = 70

    scale_target_ref {
      api_version = "apps/v1"
      kind = "Deployment"
      name = var.rm-customers-api-deployment
    }
  }

  depends_on = [kubernetes_namespace.rm_apis_namespace]
}