locals {
  hosts = [{
    name = "vnet1-bastion"
    resource_group_name = azurerm_resource_group.rg[0].name
    location = azurerm_resource_group.rg[0].location
    subnet_id            = azurerm_subnet.bastionsubnets["AzureBastionSubnet-0"].id
    public_ip_address_id = azurerm_public_ip.publicip-bastion1["publicip-bastion1"].id
},
{
    name = "vnet2-bastion"
    resource_group_name = azurerm_resource_group.rg[1].name
    location = azurerm_resource_group.rg[1].location
    subnet_id            = azurerm_subnet.bastionsubnets["AzureBastionSubnet-1"].id
    public_ip_address_id = azurerm_public_ip.publicip-bastion1["publicip-bastion2"].id
}
  ] 
}
resource "azurerm_bastion_host" "vnet1-bastion" {
    for_each = {for host in local.hosts : host.name => host}
  name                = each.key
  resource_group_name = each.value.resource_group_name
  location = each.value.location

  ip_configuration {
    name                 = "bastionconfig1"
    subnet_id            = each.value.subnet_id
    public_ip_address_id = each.value.public_ip_address_id
  }
}