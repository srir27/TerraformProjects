resource "azurerm_virtual_network" "vnet1" {
  resource_group_name = var.rgname
  location            = var.location
  name                = var.vnet_name
  # name = var.environment == "dev" ? "dev-${var.vnet_name}" : (
  #      var.environment == "stage" ? "stage-${var.vnet_name}" : 
  #      "prod-${var.vnet_name}")
  address_space = var.address_space
  tags          = local.tags

}

