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
  name     = "TaskBoardRG-${random_integer.ri.result}"
  location = "Germany West Central"
}

resource "azurerm_service_plan" "azure_service_plan" {
  name                = "taskBoard-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.azure_rg.name
  location            = azurerm_resource_group.azure_rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "azure_web_app" {
  name                = "taskBoard-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.azure_rg.name
  location            = azurerm_resource_group.azure_rg.location
  service_plan_id     = azurerm_service_plan.azure_service_plan.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    always_on = false
  }
  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = "Data Source=tcp:${azurerm_mssql_server.sql-server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sql-database.name};User ID=${azurerm_mssql_server.sql-server.administrator_login};Password=${azurerm_mssql_server.sql-server.administrator_login_password};Trusted_Connection=False; MultipleActiveResultSets=True;"
  }
}


resource "azurerm_mssql_server" "sql-server" {
  name                         = "mssqlserver-${random_integer.ri.result}"
  resource_group_name          = azurerm_resource_group.azure_rg.name
  location                     = azurerm_resource_group.azure_rg.location
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = "thisIsKat11"

}

resource "azurerm_mssql_database" "sql-database" {
  name           = "sql-db"
  server_id      = azurerm_mssql_server.sql-server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  sku_name       = "S0"
  enclave_type   = "VBS"
  zone_redundant = false
  #   storage_account_type = "local"

}


resource "azurerm_mssql_firewall_rule" "firewallRule" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.sql-server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}


resource "azurerm_app_service_source_control" "azure_service_source_control" {
  app_id                 = azurerm_linux_web_app.azure_web_app.id
  repo_url               = "https://github.com/denniesia/TaskBoard-ASP.NET-App-Deploy"
  branch                 = "main"
  use_manual_integration = true
}

