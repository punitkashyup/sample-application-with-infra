module "resource_group" {
  source = "./modules/resource_group"
  
  resource_group_name     = var.resource_group_name
  resource_group_location = var.location
  tags                    = var.tags
}

module "aks" {
  source = "./modules/aks"
  
  depends_on = [module.resource_group]
  
  cluster_name           = var.cluster_name
  resource_group_name    = module.resource_group.name
  location              = module.resource_group.location
  kubernetes_version    = var.kubernetes_version
  dns_prefix           = var.dns_prefix
  
  default_node_pool     = var.default_node_pool
  network_profile       = var.network_profile
  identity             = var.identity
  tags                 = var.tags
}

module "kubernetes_resources" {
  source = "./modules/kubernetes_resources"
  
  depends_on = [module.aks]
  
  kube_config     = module.aks.kube_config
  acme_email      = var.acme_email
  nginx_replicas  = var.nginx_replicas
  namespace_name  = var.namespace_name
  environment     = var.environment
  mongodb_username = var.mongodb_username
  mongodb_password = var.mongodb_password
  mongodb_root_password = var.mongodb_root_password  # Change this
  mongodb_database = var.mongodb_database
  mongodb_storage_size = var.mongodb_storage_size  # Adjust based on your needs
  mongodb_memory_request = var.mongodb_memory_request
  mongodb_cpu_request = var.mongodb_cpu_request
  mongodb_memory_limit = var.mongodb_memory_limit
  mongodb_cpu_limit = var.mongodb_cpu_limit
}