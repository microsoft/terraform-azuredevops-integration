output "resource_group" {
    value = azurerm_resource_group.k8s_rg
}
output "log-analytics-workspace-id" {
  value = azurerm_log_analytics_workspace.logs_workspace.id
}
output "azure-container-registry-id"{
  value = azurerm_container_registry.acr.id
}
output "random-id-suffix-dec"{
  value = random_id.random_suffix.dec
}
