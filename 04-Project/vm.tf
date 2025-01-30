# Create a null resource for local-exec provisioner to create a file with the vm deployment start time
resource "null_resource" "vmdeploy_start" {
  triggers = {
    always_run = "${timestamp()}" # Always run the provisioner
  }
  # Create a file with the deployment start time in the local directory
  provisioner "local-exec" {
    command = "echo 'The deployment started at ${timestamp()}' > vmdeploy-${timestamp()}.log"
  }

}

# Create a network interface
resource "azurerm_network_interface" "nic" {
  name                = "tfprvsnrs-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "vmipconfig"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

# Create a virtual machine
resource "azurerm_linux_virtual_machine" "vml" {
  name                            = "tfprvsnrs-lnxvm"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_DS1_v2"
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  network_interface_ids           = [azurerm_network_interface.nic.id]
  computer_name                   = "prvsnrsvm"
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  depends_on = [null_resource.vmdeploy_start] # Ensure the null resource runs first


  provisioner "file" {
    source      = "./nginxinstall.sh"
    destination = "/home/adminuser/nginxinstall.sh"
    connection {
      host     = azurerm_public_ip.pip.ip_address
      type     = "ssh"
      user     = "adminuser"
      password = var.admin_password
    }

  }

  provisioner "remote-exec" {
    connection {
      host     = azurerm_public_ip.pip.ip_address
      type     = "ssh"
      user     = "adminuser"
      password = var.admin_password
    }
    inline = [
      "chmod +x /home/adminuser/nginxinstall.sh",
      "sudo /home/adminuser/nginxinstall.sh"
    ]
  }

}



# Create a null resource for local-exec provisioner to create a file with the vm deployment end time
resource "null_resource" "vmdeploy_end" {
  triggers = {
    always_run = "${timestamp()}" # Always run the provisioner
  }
  # Create a file with the deployment end time in the local directory

  provisioner "local-exec" {
    command = "echo 'The virtual machine name ${azurerm_linux_virtual_machine.vml.name} is configured with nginx and deployed at ${timestamp()} ' > vmconfig-${timestamp()}.log"
  }
    depends_on = [ azurerm_linux_virtual_machine.vml ]
}

# Output the public IP address of the virtual machine   
output "name" {
  value = azurerm_linux_virtual_machine.vml.public_ip_address
  
}