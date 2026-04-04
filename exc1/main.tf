terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.67.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "2dfcbb9e-2105-4f58-a821-925c203b6ca4"

}

resource "azurerm_resource_group" "azure_rg" {
  name     = "terraform-Resource-Group"
  location = "Poland Central"
}