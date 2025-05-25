resource "azurerm_subnet" "snet1" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = var.snet_space
  depends_on = [ azurerm_virtual_network.vnet1 ]
}