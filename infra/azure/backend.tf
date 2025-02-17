terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = module.aks.kube_config != null ? yamldecode(module.aks.kube_config)["clusters"][0]["cluster"]["server"] : null
  cluster_ca_certificate = module.aks.kube_config != null ? base64decode(yamldecode(module.aks.kube_config)["clusters"][0]["cluster"]["certificate-authority-data"]) : null
  client_certificate     = module.aks.kube_config != null ? base64decode(yamldecode(module.aks.kube_config)["users"][0]["user"]["client-certificate-data"]) : null
  client_key             = module.aks.kube_config != null ? base64decode(yamldecode(module.aks.kube_config)["users"][0]["user"]["client-key-data"]) : null
}

provider "helm" {
  kubernetes {
    host                   = module.aks.kube_config != null ? yamldecode(module.aks.kube_config)["clusters"][0]["cluster"]["server"] : null
    cluster_ca_certificate = module.aks.kube_config != null ? base64decode(yamldecode(module.aks.kube_config)["clusters"][0]["cluster"]["certificate-authority-data"]) : null
    client_certificate     = module.aks.kube_config != null ? base64decode(yamldecode(module.aks.kube_config)["users"][0]["user"]["client-certificate-data"]) : null
    client_key             = module.aks.kube_config != null ? base64decode(yamldecode(module.aks.kube_config)["users"][0]["user"]["client-key-data"]) : null
  }
}

provider "kubectl" {
  host                   = module.aks.kube_config != null ? yamldecode(module.aks.kube_config)["clusters"][0]["cluster"]["server"] : null
  cluster_ca_certificate = module.aks.kube_config != null ? base64decode(yamldecode(module.aks.kube_config)["clusters"][0]["cluster"]["certificate-authority-data"]) : null
  client_certificate     = module.aks.kube_config != null ? base64decode(yamldecode(module.aks.kube_config)["users"][0]["user"]["client-certificate-data"]) : null
  client_key             = module.aks.kube_config != null ? base64decode(yamldecode(module.aks.kube_config)["users"][0]["user"]["client-key-data"]) : null
  load_config_file       = false
}