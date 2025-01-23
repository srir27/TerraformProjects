locals {
  bastionsubnets = [
    {
        name = "AzureBastionSubnet"
        address_prefixes = ["10.0.250.0/27"]
        resource_group_name = azurerm_resource_group.rg[0].name
        virtual_network_name = azurerm_virtual_network.vnet1.name
    },
        {
        name = "AzureBastionSubnet"
        address_prefixes = ["10.1.250.0/27"]
        resource_group_name = azurerm_resource_group.rg[1].name
        virtual_network_name = azurerm_virtual_network.vnet2.name
    }
  ]
}

resource "azurerm_subnet" "bastionsubnets" {
    for_each = {for i, bastion in local.bastionsubnets : "${bastion.name}-${i}" => bastion}
    # changing the key name to include the index since the subnets names are same (AzureBastionSubnet) in both the VNETs
    resource_group_name = each.value.resource_group_name
    virtual_network_name = each.value.virtual_network_name
    name = each.value.name
    address_prefixes = each.value.address_prefixes
}