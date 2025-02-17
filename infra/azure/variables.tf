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

variable "namespace_name" {
  type        = string
}

variable "environment" {
  type        = string
}

variable "mongodb_chart_version" {
  type        = string
  description = "Version of the MongoDB Helm chart"
  default     = "13.9.0"  # Check for latest version on https://github.com/bitnami/charts/tree/main/bitnami/mongodb
}

variable "mongodb_root_password" {
  type        = string
  description = "MongoDB root password"
  sensitive   = true
}

variable "mongodb_username" {
  type        = string
  description = "MongoDB application username"
}

variable "mongodb_password" {
  type        = string
  description = "MongoDB application password"
  sensitive   = true
}

variable "mongodb_database" {
  type        = string
  description = "MongoDB database name"
}

variable "mongodb_storage_size" {
  type        = string
  description = "Storage size for MongoDB"
  default     = "8Gi"
}

variable "mongodb_memory_request" {
  type        = string
  description = "Memory request for MongoDB"
  default     = "256Mi"
}

variable "mongodb_cpu_request" {
  type        = string
  description = "CPU request for MongoDB"
  default     = "250m"
}

variable "mongodb_memory_limit" {
  type        = string
  description = "Memory limit for MongoDB"
  default     = "512Mi"
}

variable "mongodb_cpu_limit" {
  type        = string
  description = "CPU limit for MongoDB"
  default     = "500m"
}