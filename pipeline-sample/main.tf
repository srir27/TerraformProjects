module "network" {
  source        = "./modules/network"
  rg_name       = azurerm_resource_group.rg1.name
  location      = azurerm_resource_group.rg1.location
  vnet_name     = var.vnet_name
  tags          = var.tags
  address_space = var.address_space
  subnet_name   = var.subnet_name
  snet_space    = var.snet_space

}