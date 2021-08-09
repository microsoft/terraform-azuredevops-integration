##############################################################################################################
# RESOURCES - (front-door)
##############################################################################################################

resource "azurerm_frontdoor" "frontDoor" {
  name                                         = local.frontdoor_name
  resource_group_name                          = azurerm_resource_group.k8s_rg.name
  enforce_backend_pools_certificate_name_check = false

  routing_rule {
    name                = "routingRule"
    accepted_protocols  = [ "Http", "Https" ]
    patterns_to_match   = [ "/*" ]
    frontend_endpoints = [ local.frontdoor_name ]
    
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "backendPool"
    }
  }

  backend_pool_load_balancing {
    name = "loadBalancingSettings"
  }

  backend_pool_health_probe {
    name = "healthProbeSetting"
  }

  backend_pool {
    name = "backendPool"
    
    backend {
      host_header = "k8s-${var.proj_id}-${var.environment}.westus2.cloudapp.azure.com"
      address     = "k8s-${var.proj_id}-${var.environment}.westus2.cloudapp.azure.com"
      http_port   = 80
      https_port  = 443
    }

    backend {
      host_header = "k8s-${var.proj_id}-${var.environment}.eastus2.cloudapp.azure.com"
      address     = "k8s-${var.proj_id}-${var.environment}.eastus2.cloudapp.azure.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "loadBalancingSettings"
    health_probe_name   = "healthProbeSetting"
  }

  frontend_endpoint {
    name                              = local.frontdoor_name
    host_name                         = local.front-door-hostname
  }
  tags = local.common_tags
}