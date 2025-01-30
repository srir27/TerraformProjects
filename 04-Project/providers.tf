terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0" # Provider version
    }
  }
  required_version = ">=1.8.0" # Terraform version
}

provider "azurerm" {
  # Configuration options for the providers
  features {}
  subscription_id = var.subscription_id # Subscription ID

}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "tfprvsnrs-rg"
  location = "North Europe"

} 