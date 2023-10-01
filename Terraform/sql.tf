resource "azurerm_mssql_server" "sql_server" {
  name                          = "${var.identifier}${var.environment}${var.application}${var.iteration}-sql-srv"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  version                       = "12.0"
  administrator_login           = "${azurerm_key_vault_secret.AzureSQL-Admin-Login.value}"
  administrator_login_password  = "${azurerm_key_vault_secret.AzureSQL-Admin-Password.value}"
  tags                          = var.tags
  
  azuread_administrator {
    azuread_authentication_only = true
    # login_username will be 'sp-service-principal' as expected
    login_username = data.azurerm_client_config.current.client_id
    # object_id will be set to the Enterprise Application's object_id: "11111111-1111-1111-1111-111111111111"
    # This is WRONG or at least different from the Azure portal.
    object_id      = data.azurerm_client_config.current.object_id
    # To actually grab the right ID, we have to get application_id instead:
    # object_id      = data.azuread_service_principal.spn.application_i
  }
  
  identity { 
        type = "SystemAssigned" 
    }
  
}

resource "azurerm_mssql_database" "sql_server_db" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-sql-db0"
  server_id           = azurerm_mssql_server.sql_server.id
  tags                = var.tags
}

resource "azurerm_storage_account" "sql_server_threat_detection" {
  name                     = "${var.identifier}${var.environment}${var.application}${var.iteration}stsqlthr"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_type
  account_kind             = var.storage_account_kind
  min_tls_version          = var.storage_min_tls_version
  is_hns_enabled           = false
  tags                     = var.tags
  identity { 
        type = "SystemAssigned" 
    }
}