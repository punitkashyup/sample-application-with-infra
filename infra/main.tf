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