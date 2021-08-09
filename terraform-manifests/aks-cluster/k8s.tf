# ##############################################################################################################
# # RESOURCES - (AKS)
# ##############################################################################################################

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${local.aks_name}-${var.aks_location}"
  location            = var.aks_location
  resource_group_name = local.resource_group_name
  dns_prefix          = "${local.aks_name}-${var.aks_location}"
  kubernetes_version  = var.aks.version
  node_resource_group = "MC_${local.resource_group_name}-${var.aks_location}"

  default_node_pool {
    name                    = var.aks.node_pool_name
    enable_auto_scaling     = true
    max_count               = var.max_node_count[local.environment]
    min_count               = var.min_node_count[local.environment]
    type                    = var.aks.type
    vm_size                 = var.vm_size[local.environment]
    availability_zones      = [ 1,2,3 ]
  }
  
  identity {
    type = var.aks.identity_type
  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed = true
       admin_group_object_ids = [
         var.aadgroup_id
       ]
    }
  }

  addon_profile {
    azure_policy {
      enabled = true
    }
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  network_profile {
    load_balancer_sku = var.aks.lb_sku
    network_plugin    = var.aks.network_plugin
  }

  tags = local.common_tags
}
