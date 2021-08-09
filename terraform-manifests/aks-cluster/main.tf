##############################################################################################################
# PROVIDERS
##############################################################################################################
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.61.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "=2.3.1"
    }
     helm = {
      source = "hashicorp/helm"
      version = "=2.1.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "=1.11.1"
    }
  }


  ##############################################################################################################
  # BACKEND - (for remote state)
  ##############################################################################################################
  backend "azurerm" {
  }
}

##############################################################################################################
# PROVIDER - (azurerm)
##############################################################################################################
provider "azurerm" {
  subscription_id            = var.subscription_id
  tenant_id                  = var.tenant_id
  client_id                  = var.client_id
  client_secret              = var.client_secret
  features {}
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.k8s.kube_admin_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_admin_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_admin_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_admin_config.0.cluster_ca_certificate)
}

##############################################################################################################
# PROVIDER - (Helm)
##############################################################################################################
provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.k8s.kube_admin_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_admin_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_admin_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_admin_config.0.cluster_ca_certificate)
  }
}

##############################################################################################################
# PROVIDER - (Kubectl)
##############################################################################################################
provider "kubectl" {
  load_config_file       = false
  host                   = azurerm_kubernetes_cluster.k8s.kube_admin_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_admin_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_admin_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_admin_config.0.cluster_ca_certificate)
}