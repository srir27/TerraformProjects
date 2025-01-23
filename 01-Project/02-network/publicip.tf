resource "azurerm_public_ip" "lb_publicip" {
  resource_group_name = var.rgname
  location            = var.location
  name                = local.lb_publicip_name
  allocation_method   = "Static"
  tags                = local.tags
  domain_name_label = "${var.rgname}-pubicip"

}

resource "azurerm_public_ip" "nat_publicip" {
  resource_group_name = var.rgname
  location            = var.location
  name                = local.nat_publicip_name
  allocation_method   = "Static"
  tags                = local.tags
  sku = "Standard"
}

