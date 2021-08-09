# ##############################################################################################################
# # RESOURCES - (ACR and AKS Cluster role assignment to fetch images)
# ##############################################################################################################

resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = var.acr_id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
}