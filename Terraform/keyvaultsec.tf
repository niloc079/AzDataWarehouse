
resource "azurerm_key_vault" "kv-sec" {
  name                          = "${var.identifier}${var.environment}${var.application}${var.iteration}-kv-sec"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  enabled_for_disk_encryption   = false
  tenant_id                     = var.tenant_id
  purge_protection_enabled      = false
  #soft_delete_retention_days   = 90
  sku_name                      = "standard"
  tags                          = var.tags

  network_acls {
    default_action            = "Allow"
    bypass                    = "AzureServices"
    ip_rules                  = ["${data.http.ip.response_body}"]
  }

   access_policy {
      tenant_id    = data.azurerm_client_config.current.tenant_id
      object_id    = data.azurerm_client_config.current.object_id
      
      certificate_permissions = [
         "Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers"
         ]
      key_permissions = [
         "Get", "List", "Update" , "Create", "Import", "Delete", "Recover", "Backup", "Restore"
         ]
      secret_permissions = [
         "Get", "List" , "Set" , "Delete" , "Recover" , "Backup" , "Restore", "Purge",
      ]
   }

 }

resource "azurerm_key_vault_access_policy" "kv_sec_access_policy_adf_id" {
  key_vault_id = azurerm_key_vault.kv-sec.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_data_factory.adf.identity[0].principal_id

  certificate_permissions = [
     "Get", "List",
  ]
  key_permissions = [
     "Get", "List",
  ]
  secret_permissions = [
     "Get", "List",
  ]
}

resource "azurerm_key_vault_access_policy" "kv_sec_access_policy_syn_id" {
  key_vault_id = azurerm_key_vault.kv-sec.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_synapse_workspace.synapse_workspace.identity[0].principal_id
  
  certificate_permissions = [
     "Get", "List",
  ]
  key_permissions = [
     "Get", "List",
  ]
  secret_permissions = [
     "Get", "List",
  ]
}

resource "azurerm_key_vault_access_policy" "kv_sec_access_policy_sql_id" {
  key_vault_id = azurerm_key_vault.kv-sec.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_mssql_server.sql_server.identity[0].principal_id

  certificate_permissions = [
     "Get", "List",
  ]
  key_permissions = [
     "Get", "List",
  ]
  secret_permissions = [
     "Get", "List",
  ]
}

#Password
resource "random_password" "random_password_sec" {
  length = 20
  special = true
}

resource "azurerm_key_vault_secret" "AzureSQL-Admin-Login" {
  name         = "AzureSQL-Admin-Login"
  value        = "dbaadmin"
  key_vault_id = azurerm_key_vault.kv-sec.id
}

resource "azurerm_key_vault_secret" "AzureSQL-Admin-Password" {
  name         = "AzureSQL-Admin-Password"
  value        = random_password.random_password_sec.result
  key_vault_id = azurerm_key_vault.kv-sec.id
}

resource "azurerm_key_vault_secret" "AzureSynapseSQL-Admin-Login" {
  name         = "AzureSynapseSQL-Admin-Login"
  value        = "dbaadmin"
  key_vault_id = azurerm_key_vault.kv-sec.id
}

resource "azurerm_key_vault_secret" "AzureSynapseSQL-Admin-Password" {
  name         = "AzureSynapseSQL-Admin-Password"
  value        = random_password.random_password_sec.result
  key_vault_id = azurerm_key_vault.kv-sec.id
}

