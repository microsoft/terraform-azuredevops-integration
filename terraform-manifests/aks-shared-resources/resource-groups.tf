##############################################################################################################
# RESOURCES (Resopurce Group)
##############################################################################################################
resource "azurerm_resource_group" "k8s_rg" {
  name      = local.aks_rg_name
  location  = var.resourcegroup_location
  tags      = local.common_tags
}