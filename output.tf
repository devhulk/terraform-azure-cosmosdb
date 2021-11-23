output "read_endpoints" {
    value = azurerm_cosmosdb_account.example.read_endpoints
    sensitive = false
}

output "write_endpoints" {
    value = azurerm_cosmosdb_account.example.write_endpoints
    sensitive = false
}

output "connection_strings" {
    value = azurerm_cosmosdb_account.example.connection_strings
    sensitive = false
}

