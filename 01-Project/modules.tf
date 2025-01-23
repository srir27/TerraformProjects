module "resourcegroup" {
  source   = "./01-resourcegroup"
  rgname   = "${var.rgname}-${var.suffix}"
  location = var.location
}

module "network" {
  source        = "./02-network"
  rgname        = module.resourcegroup.rgname
  vnet_name     = "${var.vnet_name}-${var.suffix}"
  lbname        = "${var.lbname}-${var.suffix}"
  subnet_name   = var.subnet_name
  address_space = var.address_space

  depends_on = [module.resourcegroup]
}

module "vm" {
  source                          = "./03-vm"
  rgname                          = module.resourcegroup.rgname
  location                        = var.location
  vmssname                        = var.vmssname
  subnet_id_from_network          = module.network.subnet_id_from_network
  backendpool = module.network.backendpool
  ssh_rule = module.network.ssh_rule
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  probe = module.network.probe
  

  depends_on = [module.network, module.resourcegroup]

}
