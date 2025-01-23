output "subnet_id_from_network" {
value = azurerm_subnet.subnet[keys(var.subnet_name)[0]].id
  //keys() takes a map and returns a list containing the keys from that map.
}

output "backendpool" {
  value = azurerm_lb_backend_address_pool.backendpool.id

}
output "ssh_rule" {
  value = azurerm_lb_nat_pool.ssh_nat_pool.id
  
}
output "nat_publicip" {
  value = azurerm_public_ip.nat_publicip.id
}


output "probe" {
  value = azurerm_lb_probe.probe.id
}

# output "ssh_rule" {
#   value = azurerm_lb_nat_rule.ssh_rule.id
# }