terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.16.0"
    }
      }
      // required_version = "value"
}

provider "azurerm" {
  # Configuration options
  features { }
  subscription_id =  var.subscription_id
}
