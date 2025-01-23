resource "azurerm_network_security_group" "nsg1" {
  name                = local.nsg1_name
  resource_group_name = var.rgname
  location            = var.location
  tags                = local.tags
  depends_on          = [azurerm_subnet.subnet]
}

locals {
  # List of NSG rules with attributes for each rule
  nsg_rule = [
    {
      name                   = "allow-ssh"
      protocol               = "Tcp"
      priority               = 500
      source_port_range      = "*"    
      destination_port_range = "22"
      direction              = "Inbound"
      access                 = "Allow"
    },
    {
      name                   = "allow-http"
      protocol               = "Tcp"  
      priority               = 520
      source_port_range      = "*"    
      destination_port_range = "80"
      direction              = "Inbound"
      access                 = "Allow"
    },
    {
      name                   = "allow-https"
      protocol               = "Tcp"  
      priority               = 530
      source_port_range      = "*"    
      destination_port_range = "443"
      direction              = "Inbound"
      access                 = "Allow"
    },
    {
      name                   = "allow-ssh-lb"
      protocol               = "Tcp"
      priority               = 400
      source_port_range      = "*"    
      destination_port_range = "5000-5010"
      direction              = "Inbound"
      access                 = "Allow"
    },
  ]
}

resource "azurerm_network_security_rule" "nsg_allow" {
  for_each = { for rule in local.nsg_rule : rule.name => rule }

  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rgname
  network_security_group_name = azurerm_network_security_group.nsg1.name
}

resource "azurerm_network_security_rule" "nsg_deny" {
  name                        = "deny-all"
  priority                    = 2000
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rgname
  network_security_group_name = azurerm_network_security_group.nsg1.name
}
