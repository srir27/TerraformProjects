terraform {
  backend "azurerm" {
    resource_group_name  = "tf-backend-project1"         # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "tfbckndstatestore01"         # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstatefile01"               # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "project01.terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}
