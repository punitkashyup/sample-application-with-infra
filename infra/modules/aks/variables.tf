variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "location" {
  type        = string
  description = "Location of the AKS cluster"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix of the AKS cluster"
}

variable "default_node_pool" {
  type = object({
    name                = string
    node_count          = number
    vm_size             = string
    enable_auto_scaling = bool
    min_count          = optional(number)
    max_count          = optional(number)
    os_disk_size_gb    = number
  })
  description = "Default node pool configuration"
}

variable "additional_node_pools" {
  type = map(object({
    node_count          = number
    vm_size             = string
    enable_auto_scaling = bool
    min_count          = optional(number)
    max_count          = optional(number)
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