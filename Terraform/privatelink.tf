#
resource "azurerm_private_endpoint" "pl-st-adl" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-st-adl"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = azurerm_subnet.vnet-subnet-1.id
  tags                = var.tags

  private_service_connection {
    name                              = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-st-adl"
    private_connection_resource_id    = azurerm_storage_account.datalake.id
    subresource_names                 = [ "blob" ]
    is_manual_connection              = false
    }

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink-blob-core-windows-net.id]
  }
}

resource "azurerm_private_endpoint" "pl-st-thr" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-st-thr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = azurerm_subnet.vnet-subnet-1.id
  tags                = var.tags

  private_service_connection {
    name                              = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-st-thr"
    private_connection_resource_id    = azurerm_storage_account.sql_server_threat_detection.id
    subresource_names                 = [ "blob" ]
    is_manual_connection              = false
    }

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink-blob-core-windows-net.id]
  }
}

resource "azurerm_private_endpoint" "pl-adf" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-adf"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = azurerm_subnet.vnet-subnet-1.id
  tags                = var.tags

  private_service_connection {
    name                              = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-adf"
    private_connection_resource_id    = azurerm_data_factory.adf.id
    subresource_names                 = [ "dataFactory" ]
    is_manual_connection              = false
    }

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink-datafactory-azure-net.id]
  }
}

resource "azurerm_private_endpoint" "pl-adf-prt" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-adf-prt"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = azurerm_subnet.vnet-subnet-1.id
  tags                = var.tags

  private_service_connection {
    name                              = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-adf-prt"
    private_connection_resource_id    = azurerm_data_factory.adf.id
    subresource_names                 = [ "portal" ]
    is_manual_connection              = false
    }

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink-datafactory-azure-net.id]
  }
}

resource "azurerm_private_endpoint" "pl-sql" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-sql"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = azurerm_subnet.vnet-subnet-1.id
  tags                = var.tags

  private_service_connection {
    name                              = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-sql"
    private_connection_resource_id    = azurerm_mssql_server.sql_server.id
    subresource_names                 = [ "sqlServer" ]
    is_manual_connection              = false
    }

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink-database-windows-net.id]
  }
}

resource "azurerm_private_endpoint" "pl-syn" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-syn"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = azurerm_subnet.vnet-subnet-1.id
  tags                = var.tags

  private_service_connection {
    name                              = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-syn"
    private_connection_resource_id    = azurerm_synapse_workspace.synapse_workspace.id
    subresource_names                 = [ "Sql" ]
    is_manual_connection              = false
    }

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink-database-windows-net.id]
  }
}

resource "azurerm_private_endpoint" "pl-kv-sec" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-kv-sec"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = azurerm_subnet.vnet-subnet-1.id
  tags                = var.tags

  private_service_connection {
    name                              = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-kv-sec"
    private_connection_resource_id    = azurerm_key_vault.kv-sec.id
    subresource_names                 = [ "vault" ]
    is_manual_connection              = false
    }

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink-vaultcore-azure-net.id]
  }
}

resource "azurerm_private_endpoint" "pl-kv-app" {
  name                = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-kv-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = azurerm_subnet.vnet-subnet-1.id
  tags                = var.tags

  private_service_connection {
    name                              = "${var.identifier}${var.environment}${var.application}${var.iteration}-pl-kv-app"
    private_connection_resource_id    = azurerm_key_vault.kv-app.id
    subresource_names                 = [ "vault" ]
    is_manual_connection              = false
    }

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink-vaultcore-azure-net.id]
  }
}
