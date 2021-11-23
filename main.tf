terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.team_name}-cosmosdb-rg-${random_integer.ri.result}"
  location = var.region
}

resource "azurerm_cosmosdb_account" "example" {
  name                = "${var.team_name}-cosmos-db-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = var.failover_location
    failover_priority = 1
  }

  geo_location {
    location          = azurerm_resource_group.rg.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "example" {
  count =               var.db == "sql" ? 1 : 0 
  name                = "${var.team_name}-cosmos-sql-db"
  resource_group_name = azurerm_cosmosdb_account.example.resource_group_name
  account_name        = azurerm_cosmosdb_account.example.name
  throughput          = 400
}

resource "azurerm_cosmosdb_mongo_database" "example" {
  count =               var.db == "mongo" ? 1 : 0 
  name                = "${var.team_name}-cosmos-mongo-db"
  resource_group_name = azurerm_cosmosdb_account.example.resource_group_name
  account_name        = azurerm_cosmosdb_account.example.name
  throughput          = 400
}