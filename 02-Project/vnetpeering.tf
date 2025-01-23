resource "azurerm_virtual_network_peering" "vnetpeer1" {
  resource_group_name = azurerm_resource_group.rg[0].name
  name = "vnet1-vnet2-peering"
  virtual_network_name = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id

    allow_virtual_network_access = true
  allow_forwarded_traffic      = true

}

resource "azurerm_virtual_network_peering" "vnetpeer2" {
  resource_group_name = azurerm_resource_group.rg[1].name
  name = "vnet2-vnet1-peering"
  virtual_network_name = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id

    allow_virtual_network_access = true
  allow_forwarded_traffic      = true

}