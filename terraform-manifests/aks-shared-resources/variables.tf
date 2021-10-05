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
variable "log_analytics_workspace_name" {
  description = "Log analytics workspace name"
  default = "default-value"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable "log_analytics_workspace_sku" {
  default = "PerGB2018"
}

variable "application_insights_name" {
  description = "Application insights name"
  default = "default-value"
}

variable "resourcegroup_location" {
  description = "Resource group location"
  default = "westus2"
  validation {
    condition = contains(["westus2", "eastus2"], var.resourcegroup_location)
    error_message = "The resource group location must be in the list westus2, eastus2."
  }
}

variable "acr_prefix" {
  description = "ACR name"
  default = "default-value"
}

variable "proj_id" {
  description = "Identifier postfix for various resources"
  default = "default-value"
}

##############################################################################################################
# LOCALS
##############################################################################################################

locals {
  environment               = lower(var.environment)
  logs_workspace_name       = "${var.log_analytics_workspace_name}-${local.environment}-${random_id.random_suffix.dec}"
  app_insights_name         = "${var.application_insights_name}-${local.environment}-${random_id.random_suffix.dec}"
  common_tags               = { Env = local.environment }
  acr_name                  = "${var.acr_prefix}${local.environment}"
  aks_rg_name               = "k8s-${var.proj_id}-${local.environment}"
  frontdoor_name            = "fd-${var.proj_id}-${local.environment}"
  front-door-hostname       = "${local.frontdoor_name}.azurefd.net"
}