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