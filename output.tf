output "read_endpoints" {
    value = azurerm_cosmosdb_account.example.read_endpoints
    sensitive = true
}

output "write_endpoints" {
    value = azurerm_cosmosdb_account.example.write_endpoints
    sensitive = true
}

output "connection_strings" {
    value = azurerm_cosmosdb_account.example.connection_strings
    sensitive = true
}

