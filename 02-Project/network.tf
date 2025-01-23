resource "azurerm_resource_group" "rg1" {
for_each = {for rg in var.inputs : rg.rgname => rg}
// for loop creates a map and rg name is the key here
name = each.key
location = each.value.location
}

resource "azurerm_virtual_network" "vnet" {
  for_each = { for vn in var.inputs : vn.vnetname => vn}
  // vnetname is the key here
  name = each.key
  location = each.value.location
  resource_group_name = each.value.rgname
  address_space = each.value.address_space
}

# subnet definition for the first vnet
resource "azurerm_subnet" "subnet1" {
  count = length(var.subnetvnet1)
  name = element(var.subnetvnet1,count.index)
  address_prefixes = [element(var.subnetaddress1,count.index)]
  resource_group_name = tolist(var.inputs)[0].rgname
  virtual_network_name = tolist(var.inputs)[0].vnetname
  default_outbound_access_enabled = true
  depends_on = [ azurerm_resource_group.rg1, azurerm_virtual_network.vnet ]
}

# subnet definition for the second vnet
resource "azurerm_subnet" "subnet2" {
  count = length(var.subnetvnet2)
  name = element(var.subnetvnet2,count.index)
  address_prefixes = [element(var.subnetaddress2,count.index)]
  resource_group_name = tolist(var.inputs)[1].rgname
  virtual_network_name = tolist(var.inputs)[1].vnetname
  default_outbound_access_enabled = true
   depends_on = [ azurerm_resource_group.rg1, azurerm_virtual_network.vnet ]
}

resource "azurerm_network_security_group" "nsginbound" {
  for_each = {for rg in var.inputs : rg.rgname => rg}
  name                = "nsginbound"
  location            = each.value.location
  resource_group_name = each.key

  security_rule {
    name                       = "allowallinbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [ azurerm_resource_group.rg1]
}


resource "azurerm_subnet_network_security_group_association" "subnet-nsg-assoc" {
  for_each                  = var.subnetvnet1
  subnet_id                 = azurerm_subnet.subnet1[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}
# resource "azurerm_subnet_network_security_group_association" "nsg-assoc1" {
#   for_each = azurerm_network_security_group.nsginbound
#   network_security_group_id = each.value.id
#   # to associate this to all the subnets in vnet1
#   // for_each = {for subnet in azurerm_subnet.subnet1 : subnet.name => subnet}
#   subnet_id = azurerm_subnet.subnet1[0].id
# }

# resource "azurerm_subnet_network_security_group_association" "nsg-assoc2" {
#   for_each = azurerm_network_security_group.nsginbound
#   network_security_group_id = each.value.id
#   # to associate this to all the subnets in vnet1
#   // for_each = {for subnet in azurerm_subnet.subnet1 : subnet.name => subnet}
#   subnet_id = azurerm_subnet.subnet2[0].id
# }