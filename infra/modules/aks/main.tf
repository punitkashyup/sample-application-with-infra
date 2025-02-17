resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix         = var.dns_prefix
  kubernetes_version = var.kubernetes_version

  default_node_pool {
    name                = var.default_node_pool.name
    node_count          = var.default_node_pool.enable_auto_scaling ? null : var.default_node_pool.node_count
    vm_size             = var.default_node_pool.vm_size
    os_disk_size_gb    = var.default_node_pool.os_disk_size_gb
    enable_auto_scaling = var.default_node_pool.enable_auto_scaling
    min_count          = var.default_node_pool.enable_auto_scaling ? var.default_node_pool.min_count : null
    max_count          = var.default_node_pool.enable_auto_scaling ? var.default_node_pool.max_count : null
  }

  identity {
    type = var.identity.type
  }

  network_profile {
    network_plugin     = var.network_profile.network_plugin
    load_balancer_sku = var.network_profile.load_balancer_sku
  }

  tags = var.tags
}

# For additional node pools
resource "azurerm_kubernetes_cluster_node_pool" "additional_pools" {
  for_each = var.additional_node_pools

  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size              = each.value.vm_size
  node_count           = each.value.enable_auto_scaling ? null : each.value.node_count
  os_disk_size_gb      = each.value.os_disk_size_gb
  enable_auto_scaling  = each.value.enable_auto_scaling
  min_count           = each.value.enable_auto_scaling ? each.value.min_count : null
  max_count           = each.value.enable_auto_scaling ? each.value.max_count : null
}