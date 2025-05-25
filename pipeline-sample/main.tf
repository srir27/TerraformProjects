module "network" {
  source = "./modules/network"

  vnet_name     = module.network.vnet_name
  tags          = var.tags
  address_space = module.network.address_space
  subnet_name   = module.network.subnet_name
  snet_space    = module.network.snet_space
  
}