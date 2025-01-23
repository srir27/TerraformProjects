# resource "azurerm_network_interface" "linux-nic" {
#   count               = var.vmcount
#   name                = "tfvm-nic-${count.index}"
#   resource_group_name = var.rgname
#   location            = var.location
#   tags = local.tags
#   ip_configuration {
#     name                          = "PublicIPAddress"
#     subnet_id                     = var.subnet_id_from_network
#     private_ip_address_allocation = "Dynamic"

#   }

# }
# locals {
#   linux_vmsize = "Standard_B1s"
# }

# # Adds all the VMs to the backend pool using their NICs
# resource "azurerm_network_interface_backend_address_pool_association" "linux-nic-backend-pool" {
#   count                    = var.vmcount
#   network_interface_id     = azurerm_network_interface.linux-nic[count.index].id
#   ip_configuration_name    = "PublicIPAddress"
#   backend_address_pool_id  = var.loadblncrbacked_id_from_network

# }


# resource "azurerm_linux_virtual_machine" "linux_server" {
#   count                           = var.vmcount
#   # to retrieve the name of the VM from the list of VM names, element function is used
#   name                            = "tfvm-${count.index}"
#   resource_group_name             = var.rgname
#   location                        = var.location
#   tags                            = local.tags
#   network_interface_ids           = [azurerm_network_interface.linux-nic[count.index].id]
#   size                            = local.linux_vmsize
#   disable_password_authentication = false
#   admin_username                  = var.admin_username
#   admin_password                  = var.admin_password
  
  
#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#     name = "tfvm-osdisk-${count.index}"
    
#   }
#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# custom_data = base64encode(file("${path.module}/user_data.sh"))

#   #custom_data = (base64encode(file("nginx_install.sh")))
#   # # Remote-exec provisioner to install NGINX after VM boot and needs a Public IP directly assigned to the VM
#   # provisioner "remote-exec" {
#   #   inline = [
#   #     "sudo apt-get update -y",
#   #     "sudo apt-get install -y nginx",
#   #     "sudo systemctl start nginx",
#   #     "sudo systemctl enable nginx"
#   #   ]

#   #   connection {
#   #     host     = self.public_ip
#   #     user     = var.admin_name
#   #     password = var.admin_pwd
#   #     type     = "ssh"
#   #   }
#   # }
# }

