# ##############################################################################################################
# # RESOURCES - (ACR)
# ##############################################################################################################

resource "azurerm_container_registry" "acr" {
  name = "${local.acr_name}${random_id.random_suffix.dec}"
  resource_group_name      = azurerm_resource_group.k8s_rg.name
  location                 = azurerm_resource_group.k8s_rg.location
  sku                      = "Standard"
  admin_enabled            = false
  tags                     = local.common_tags
}