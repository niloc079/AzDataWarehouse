#
resource "azurerm_storage_account" "datalake" {
  name                     = "${var.identifier}${var.environment}${var.application}${var.iteration}stadl"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_type
  account_kind             = var.storage_account_kind
  min_tls_version          = var.storage_min_tls_version
  is_hns_enabled           = true
  tags                     = var.tags
  identity { 
        type = "SystemAssigned" 
    }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "default" {
  name               = "default"
  storage_account_id = azurerm_storage_account.datalake.id
}
