resource "azurerm_subnet" "subnet" {
  # for_each is used since we need unique names with diff formats.
  # map is the datatype. key = subnetname & value = subnetaddress.
  for_each             = var.subnet_name
  resource_group_name  = local.rgname
  virtual_network_name = azurerm_virtual_network.vnet1.name
  name                 = each.key
  address_prefixes     = [each.value]
  service_endpoints    = ["Microsoft.Storage"]
  depends_on           = [azurerm_virtual_network.vnet1]
}

resource "azurerm_subnet_network_security_group_association" "subnet-nsg-assoc" {
  for_each                  = var.subnet_name
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

# resource "azurerm_subnet_nat_gateway_association" "subnet-nat-assoc" {
#   subnet_id      = azurerm_subnet.subnet[keys(var.subnet_name)[0]].id
#   nat_gateway_id = azurerm_nat_gateway.natgateway.id
# }
