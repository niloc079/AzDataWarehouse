
resource "azurerm_data_factory" "adf" {
    name                    = "${var.identifier}${var.environment}${var.application}${var.iteration}-adf"
    resource_group_name     = azurerm_resource_group.rg.name
    location                = azurerm_resource_group.rg.location
    public_network_enabled  = var.adf-public_network_enabled
    tags                    = var.tags
    identity { 
        type = "SystemAssigned" 
    }
    dynamic "vsts_configuration" {
        for_each = var.vsts_configuration[*]
    content {
      account_name                = vsts_configuration.value.vsts_account_name
      branch_name                 = vsts_configuration.value.vsts_branch_name
      project_name                = vsts_configuration.value.vsts_project_name
      repository_name             = vsts_configuration.value.vsts_repository_name
      root_folder                 = vsts_configuration.value.vsts_root_folder
      tenant_id                   = vsts_configuration.value.tenant_id
    }
  }
}