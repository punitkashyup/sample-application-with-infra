variable "kube_config" {
  type        = string
  description = "Kubernetes config file content"
  sensitive   = true
}

variable "nginx_replicas" {
  type        = number
  description = "Number of NGINX ingress controller replicas"
  default     = 2
}

variable "cert_manager_version" {
  type        = string
  description = "Version of cert-manager to install"
  default     = "v1.13.1"
}

variable "acme_server" {
  type        = string
  description = "ACME server URL for Let's Encrypt"
  default     = "https://acme-v02.api.letsencrypt.org/directory"
}

variable "acme_email" {
  type        = string
  description = "Email address for Let's Encrypt notifications"
}

# New variables for namespace
variable "namespace_name" {
  type        = string
  description = "Name of the custom namespace to create"
}

variable "environment" {
  type        = string
  description = "Environment label for the namespace (e.g., dev, staging, prod)"
  default     = "dev"
}

# MongoDB Variables
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