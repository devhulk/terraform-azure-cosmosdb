data "azurerm_cosmosdb_account" "example" {
  name                = "${var.team_name}-cosmosdb-account"
  resource_group_name = "${var.team_name}-cosmosdb-rg"
  location = "${var.region}"
}

resource "azurerm_cosmosdb_sql_database" "example" {
  count =               var.db == "sql" ? 1 : 0 
  name                = "${var.team_name}-cosmos-mongo-db"
  resource_group_name = data.azurerm_cosmosdb_account.example.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.example.name
  throughput          = 400
}

resource "azurerm_cosmosdb_mongo_database" "example" {
  count =               var.db == "mongo" ? 1 : 0 
  name                = "${var.team_name}-cosmos-mongo-db"
  resource_group_name = data.azurerm_cosmosdb_account.example.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.example.name
  throughput          = 400
}