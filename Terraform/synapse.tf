#
resource "azurerm_synapse_workspace" "synapse_workspace" {
  name                                  = "${var.identifier}${var.environment}${var.application}${var.iteration}-syn"
  resource_group_name                   = azurerm_resource_group.rg.name
  location                              = azurerm_resource_group.rg.location
  sql_identity_control_enabled          = true
  storage_data_lake_gen2_filesystem_id  = azurerm_storage_data_lake_gen2_filesystem.default.id
  sql_administrator_login               = "${azurerm_key_vault_secret.AzureSynapseSQL-Admin-Login.value}"
  sql_administrator_login_password      = "${azurerm_key_vault_secret.AzureSynapseSQL-Admin-Password.value}"
  tags                                  = var.tags

  identity {
    type = "SystemAssigned"
  }
 
    aad_admin {
    login     = data.azurerm_client_config.current.client_id
    object_id = data.azurerm_client_config.current.object_id
    tenant_id = data.azurerm_client_config.current.tenant_id
  }
}

resource "azurerm_synapse_firewall_rule" "synapse-firewall-rule-01" {
  name                 = "AllowAllWindowsAzureIps"
  synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "0.0.0.0"
}

resource "azurerm_synapse_firewall_rule" "synapse-firewall-rule-02" {
  name                 = "allowAll"
  synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "255.255.255.255"
}

resource "azurerm_synapse_firewall_rule" "synapse-firewall-rule-03" {
  name                 = "ExecutionIP"
  synapse_workspace_id = azurerm_synapse_workspace.synapse_workspace.id
  start_ip_address     = "${data.http.ip.response_body}"
  end_ip_address       = "${data.http.ip.response_body}"
}

resource "azurerm_synapse_sql_pool" "sql-pool" {
  name                       = "${var.identifier}${var.environment}${var.application}${var.iteration}pol"
  synapse_workspace_id       = azurerm_synapse_workspace.synapse_workspace.id    
  sku_name                   = var.synapse-sqlpool-sku
  create_mode                = var.synapse-sqlpool-createmode
  }

