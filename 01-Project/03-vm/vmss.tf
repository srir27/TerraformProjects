resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                            = var.vmssname
  resource_group_name             = var.rgname
  location                        = var.location
  sku                             = "Standard_D2s_v4"
  instances                       = 1
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  custom_data                     = base64encode(file("${path.module}/user_data.sh"))

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id_from_network
      load_balancer_backend_address_pool_ids = [var.backendpool]
      load_balancer_inbound_nat_rules_ids = [var.ssh_rule]
      
    }
    
  }
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
    health_probe_id = var.probe
  lifecycle {
    ignore_changes = [instances] 
}

}