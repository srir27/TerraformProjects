resource "azurerm_network_interface" "nic2" {
    count = var.vm2count
  name                = "vmnic2-${count.index}"
  resource_group_name = azurerm_resource_group.rg[1].name
  location = azurerm_resource_group.rg[1].location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet2[0].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm2" {
    count = var.vm2count
  name                = "vm2-${count.index}"
  resource_group_name = azurerm_resource_group.rg[1].name
  location = azurerm_resource_group.rg[1].location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password = "Welcome@1234"
  network_interface_ids = [
    azurerm_network_interface.nic2[count.index].id,
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