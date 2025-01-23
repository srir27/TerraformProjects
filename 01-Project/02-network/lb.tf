resource "azurerm_lb" "lb" {
  name                = var.lbname
  resource_group_name = var.rgname
  location            = var.location
  sku                 = "Standard"
  tags = local.tags

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_publicip.id
  }
  
}
resource "azurerm_lb_backend_address_pool" "backendpool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool"

}
resource "azurerm_lb_rule" "http-lbrule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.backendpool.id]
  probe_id = azurerm_lb_probe.probe.id

}
resource "azurerm_lb_probe" "probe" {
  name            = "http-probe"
  loadbalancer_id = azurerm_lb.lb.id
  protocol        = "Http"
  port            = 80
  request_path    = "/"
}

# Both nat pool and nat rule are required since we have multiple VMs behind the LB
# The association between the NAT rule and the NAT pool occurs within the configuration of the load balancer.
# Frontend IP (Load Balancer) -> NAT Pool (Port Range) -> NAT Rules (Port Mapping) -> Backend Pool (VM NICs)

# We will only add the backend pool to the nat rule. 

resource "azurerm_lb_nat_pool" "ssh_nat_pool" {
  name                           = "ssh-nat-pool"
  resource_group_name            = var.rgname
  loadbalancer_id                = azurerm_lb.lb.id
  frontend_ip_configuration_name = "PublicIPAddress"
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50009 # 10 VMs can use this ip with ports 5000-5009
  backend_port                   = 22

 }
resource "azurerm_lb_nat_rule" "ssh_rule" {
  name                           = "ssh-rule"
  resource_group_name            = var.rgname
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_ip_configuration_name = "PublicIPAddress"
  frontend_port_start            = 50000
  frontend_port_end              = 50009
  backend_port                   = 22
  backend_address_pool_id        = azurerm_lb_backend_address_pool.backendpool.id
  enable_floating_ip             = false
  idle_timeout_in_minutes        = 4
}

