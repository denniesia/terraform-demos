terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.67.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "2dfcbb9e-2105-4f58-a821-925c203b6ca4"

}

resource "random_integer" "ri" {
  min = 10000
  max = 99999

}

resource "azurerm_resource_group" "azure_rg" {
  name     = "ContactsBookRG-${random_integer.ri.result}"
  location = "Germany West Central"
}

resource "azurerm_service_plan" "azure_service_plan" {
  name                = "contact-book-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.azure_rg.name
  location            = azurerm_resource_group.azure_rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "azure_web_app" {
  name                = "contact-book-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.azure_rg.name
  location            = azurerm_resource_group.azure_rg.location
  service_plan_id     = azurerm_service_plan.azure_service_plan.id

  site_config {
    application_stack {
      node_version = "20-lts"
    }
    always_on = false
  }
}

resource "azurerm_app_service_source_control" "azure_service_source_control" {
  app_id                 = azurerm_linux_web_app.azure_web_app.id
  repo_url               = "https://github.com/nakov/ContactBook"
  branch                 = "master"
  use_manual_integration = true
}