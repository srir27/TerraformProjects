resource "azurerm_resource_group" "rg1" {
  name     = local.rgname
  location = var.location
  tags     = local.tags
  
}


