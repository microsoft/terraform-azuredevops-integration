# ###############################################################################################
# # Enable Azure Diagnostic settings in AKS clusters
# ###############################################################################################

resource "azurerm_monitor_diagnostic_setting" "k8s_diagnostic_settings" {
  name                       = "${local.aks_name}-${var.aks_location}-diagnostic-settings${var.random_id_suffix_dec}"
  target_resource_id         = azurerm_kubernetes_cluster.k8s.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "kube-apiserver"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 90
    }    
  }

  log {
    category = "kube-audit"
    enabled  = true
    
    retention_policy {
      enabled = true
      days    = 90
    } 
  }

  log {
    category = "kube-audit-admin"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 90
    } 
  }
  
  log {
    category = "kube-controller-manager"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 90
    } 
  }
  
  log {
    category = "kube-scheduler"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 90
    } 
  }
  
  log {
    category = "cluster-autoscaler"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 90
    } 
  }
  
  log {
    category = "guard"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 90
    } 
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 90
    } 
  }

  depends_on = [azurerm_kubernetes_cluster.k8s]
}