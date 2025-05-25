terraform {
  backend "azurerm" {
    resource_group_name  = "tf-backend-rg"
    storage_account_name = "tfazbackendstore2709"
    container_name       = "tf-backend"
    key                  = "statefile.tfstate"
    
  }
}