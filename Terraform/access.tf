data "azurerm_subscription" "subscription" {
}

#Synapse
resource "azurerm_role_assignment" "synapse-access1" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Storage Blob Data Contributor"
  #principal_id         = azurerm_synapse_workspace.synapse_workspace.identity[0].principal_id
  principal_id         = azurerm_synapse_workspace.synapse_workspace.identity[0].principal_id
}

#ADF
resource "azurerm_role_assignment" "adf-access1" {
  scope                 = azurerm_resource_group.rg.id
  role_definition_name  = "Storage Blob Data Contributor"
  principal_id          = azurerm_data_factory.adf.identity[0].principal_id
}

#Current User
resource "azurerm_role_assignment" "current-user-rg-dw-contributor-access1" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "current-user-rg-dw-contributor-access2" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}
