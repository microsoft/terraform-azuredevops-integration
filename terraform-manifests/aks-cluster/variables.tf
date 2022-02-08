##############################################################################################################
# VARIABLES
##############################################################################################################

variable "client_id" {}

variable "client_secret" {}

variable "tenant_id" {}

variable "subscription_id" {}
variable "environment" {
  description = "Azure resources environment"
}
variable "acr_id" {
  description = "Azure container registry id"
}

variable "log_analytics_workspace_id"{
    description = "Log analytics workspace Id"
} 
variable aks {
  description = "AKS properties"
  type = map
  default = {
    resource_group  = "default-value",
    cluster_name    = "default-value",
    node_pool_name  = "agentpool",
    type            = "VirtualMachineScaleSets"
    identity_type   = "SystemAssigned",
    lb_sku          = "Standard",
    network_plugin  = "kubenet"
    version         = "1.20.9"
  }
}

variable "vm_size" {
  type = map(string)
  default = {
    sit   = "Standard_F4s_v2"
    prod  = "Standard_F8s_v2"
  }
}

variable "max_node_count" {
  type = map(number)
  default = {
    sit   = 10
    prod  = 10 
  }
}

variable "min_node_count" {
  type = map(number)
  default = {
    sit   = 2
    prod  = 2 
  }
}

variable "aks_location" {
  description = "AKS location"
  #default = "westus2"

  validation {
    condition = contains(["westus2", "eastus2"], var.aks_location)
    error_message = "The aks location must be in the list westus2, eastus2."
  }
}
variable "ingress_replica_count" {
  description = "Replica count for ingress controller"
  default     = 2
}
variable "cert-manager-version" {
    description = "This variable defines the cert manager helm chart version"
    default = "v1.2"
}

variable "random_id_suffix_dec" {
  type = string  
}

variable "keyvault_name" {
  type = string  
}

variable "keyvault_rg" {
  type = string  
}

variable "aadgroup_id" {
  type = string  
}

variable "rm-customers-api-deployment" {
  description = "This variable defines the api deployment name"
  default = "rm-customers-api-deployment"
}

variable "proj_id" {
  description = "Identifier postfix for various resources"
  default = "default-value"
}

##############################################################################################################
# LOCALS
##############################################################################################################

locals {
  environment               = var.environment
  resource_group_name       = "k8s-${var.proj_id}-${local.environment}"
  aks_rg_name               = "${local.resource_group_name}-${local.environment}"
  aks_name                  = "${var.aks.cluster_name}-${local.environment}"
  common_tags               = { Env = local.environment }
}
