resource "azurerm_resource_group" "rg" {
    count = length(var.rgname)
  name = element(var.rgname,count.index)
  location = element(var.location,count.index)
}

#VNETs for RG1
resource "azurerm_virtual_network" "vnet1" {
  name = var.vname1
  resource_group_name = azurerm_resource_group.rg[0].name
  location = azurerm_resource_group.rg[0].location
  address_space = var.address_space1
}

# VNETs for RG2
resource "azurerm_virtual_network" "vnet2" {
  name = var.vname2
  resource_group_name = azurerm_resource_group.rg[1].name
  location = azurerm_resource_group.rg[1].location
  address_space = var.address_space2
}

#Subnets for RG1
resource "azurerm_subnet" "subnet1" {
  count = length(var.subnet1)
  resource_group_name = azurerm_resource_group.rg[0].name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  name = element(var.subnet1,count.index)
  address_prefixes = [element(var.subnet_space1,count.index)]
}

 #Subnets for RG2
resource "azurerm_subnet" "subnet2" {
    count = length(var.subnet2)
  resource_group_name = azurerm_resource_group.rg[1].name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  name = element(var.subnet2,count.index)
  address_prefixes = [element(var.subnet_space2,count.index)]
}

resource "azurerm_network_security_group" "nsginbound" {
    count = length(var.rgname)
  name                = "nsginbound"
  location            = element(var.location,count.index)
  resource_group_name = element(var.rgname,count.index)
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
  depends_on = [ azurerm_resource_group.rg]
}

resource "azurerm_subnet_network_security_group_association" "nsgsubnet1" {
  count = length(var.subnet1)
  network_security_group_id = azurerm_network_security_group.nsginbound[0].id
  subnet_id = azurerm_subnet.subnet1[count.index].id
}

resource "azurerm_subnet_network_security_group_association" "nsgsubnet2" {
  count = length(var.subnet2)
  network_security_group_id = azurerm_network_security_group.nsginbound[1].id
  subnet_id = azurerm_subnet.subnet2[count.index].id
}
