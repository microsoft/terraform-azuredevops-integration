##############################################################################################################
# RESOURCES - (Log Analytics)
##############################################################################################################
resource "azurerm_log_analytics_workspace" "logs_workspace" {
  # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
  name                = local.logs_workspace_name
  # refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
  location            = azurerm_resource_group.k8s_rg.location
  resource_group_name = azurerm_resource_group.k8s_rg.name
  sku                 = var.log_analytics_workspace_sku
  tags                = local.common_tags
}

resource "azurerm_log_analytics_solution" "logs_solution" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.logs_workspace.location
  resource_group_name   = azurerm_resource_group.k8s_rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.logs_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.logs_workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }

  tags = local.common_tags
}