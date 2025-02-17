variable "backend_resource_group_name" {
  type        = string
  description = "Resource group name for terraform backend storage"
}

variable "backend_storage_account_name" {
  type        = string
  description = "Storage account name for terraform backend"
}

variable "backend_container_name" {
  type        = string
  description = "Container name for terraform backend"
}

variable "backend_key" {
  type        = string
  description = "State file name for terraform backend"
  default     = "aks/terraform.tfstate"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for resources"
}

variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for AKS cluster"
}

variable "default_node_pool" {
  type = object({
    name                = string
    node_count          = number
    vm_size             = string
    enable_auto_scaling = bool
    min_count          = number
    max_count          = number
    os_disk_size_gb    = number
  })
  description = "Default node pool configuration"
}

variable "additional_node_pools" {
  type = map(object({
    node_count          = number
    vm_size             = string
    enable_auto_scaling = bool
    min_count          = number
    max_count          = number
    os_disk_size_gb    = number
  }))
  description = "Additional node pools configuration"
  default     = {}
}

variable "network_profile" {
  type = object({
    network_plugin     = string
    load_balancer_sku = string
  })
  description = "Network profile configuration"
}

variable "identity" {
  type = object({
    type = string
  })
  description = "Identity configuration"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to resources"
  default     = {}
}

variable "acme_email" {
  type        = string
  description = "Email address for Let's Encrypt notifications"
}

variable "nginx_replicas" {
  type        = number
  description = "Number of NGINX ingress controller replicas"
  default     = 2
}