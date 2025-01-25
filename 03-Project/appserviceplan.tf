resource "azurerm_resource_group" "rg" {
  name = "${var.rgname}-${var.suffix}"
  location = var.location
}

resource "azurerm_service_plan" "asp" {
  name                = "asp-${var.suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "S1"
  
}