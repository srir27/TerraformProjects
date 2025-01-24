resource "azurerm_network_interface" "nic1" {
    count = var.vm1count
  name                = "vmnic1-${count.index}"
  resource_group_name = azurerm_resource_group.rg[0].name
  location = azurerm_resource_group.rg[0].location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1[0].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm1" {
    count = var.vm1count
  name                = "vm1-${count.index}"
  resource_group_name = azurerm_resource_group.rg[0].name
  location = azurerm_resource_group.rg[0].location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password = "**********"
  network_interface_ids = [
    azurerm_network_interface.nic1[count.index].id,
  ]

disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
