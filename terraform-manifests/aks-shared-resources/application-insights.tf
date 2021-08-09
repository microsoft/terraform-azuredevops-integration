##############################################################################################################
# RESOURCES - (Application Insights)
##############################################################################################################

resource "azurerm_application_insights" "app_insights" {
  name                = local.app_insights_name
  location            = azurerm_resource_group.k8s_rg.location
  resource_group_name = azurerm_resource_group.k8s_rg.name
  application_type    = "web"
}