locals {
  publicips = [{
    name = "publicip-bastion1"
    resource_group_name = azurerm_resource_group.rg[0].name
    location = azurerm_resource_group.rg[0].location
},
{
    name = "publicip-bastion2"
    resource_group_name = azurerm_resource_group.rg[1].name
    location = azurerm_resource_group.rg[1].location
}]
}
resource "azurerm_public_ip" "publicip-bastion1" {
    for_each = {for publicip in local.publicips : publicip.name => publicip}
  name                = each.key
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  allocation_method   = "Static"
  sku                 = "Standard"
}