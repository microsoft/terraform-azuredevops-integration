# ###############################################################################################
# # Provide key vault access policy to Managed AKS Cluster Identity
# ###############################################################################################
data "azurerm_key_vault" "datakv" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_rg
}

resource "azurerm_key_vault_access_policy" "kv_access_policy" {
  key_vault_id = data.azurerm_key_vault.datakv.id
  tenant_id    = data.azurerm_key_vault.datakv.tenant_id
  object_id    = azurerm_kubernetes_cluster.k8s.kubelet_identity.0.object_id

  key_permissions = [
    "Get",
    "List"
  ]

  secret_permissions = [
    "Get",
    "List"
  ]
}