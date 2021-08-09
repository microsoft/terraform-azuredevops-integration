# ##############################################################################################################
# # RESOURCES - (Public IP)
# ##############################################################################################################
resource "azurerm_public_ip" "k8s_ip" {
  name                = "k8s-public-ip-${azurerm_kubernetes_cluster.k8s.location}"
  resource_group_name = azurerm_kubernetes_cluster.k8s.node_resource_group
  location            = azurerm_kubernetes_cluster.k8s.location
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_version          = "IPv4"
  domain_name_label   = local.aks_name  
}