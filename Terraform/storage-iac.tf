resource "azurerm_storage_account" "storage-iac" {
  name                     = "${var.identifier}${var.environment}${var.application}${var.iteration}stiac"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_type
  min_tls_version          = var.storage_min_tls_version
  tags                     = var.tags
  identity { 
        type = "SystemAssigned" 
    }
}

resource "azurerm_storage_container" "storage-iac-tfstate" {
  name                  = "${var.identifier}${var.environment}${var.application}${var.iteration}-rg"
  storage_account_name  = azurerm_storage_account.storage-iac.name
  container_access_type = "private"
}
