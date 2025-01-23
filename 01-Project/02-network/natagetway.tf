# Add nat gateway to enable outbound traffic from the backend instances
resource "azurerm_nat_gateway" "nat_gw" {
  name                    = "nat-gateway"
  location                = var.location
  resource_group_name     = var.rgname
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  tags = local.tags

}

# Associating a NAT gateway to a subnet
resource "azurerm_subnet_nat_gateway_association" "subnet_natgw_assoc" {
  subnet_id      = azurerm_subnet.subnet[keys(var.subnet_name)[0]].id // Associating to the first subnet
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}

# Associating nat gateway with a public ip 
resource "azurerm_nat_gateway_public_ip_association" "natgw_pubip_assoc" {
  public_ip_address_id = azurerm_public_ip.nat_publicip.id
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
}