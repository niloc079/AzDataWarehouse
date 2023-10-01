#
#Why Local env? These should be in the hub and not part of this repo
locals {
  environment               = "hub"
}

#Resource Group
resource "azurerm_resource_group" "dns-rg" {
    name                    = "${local.environment}dns-rg"
    location                = var.location
}

#
# https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns
resource "azurerm_private_dns_zone" "privatelink-blob-core-windows-net" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.dns-rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink-blob-core-windows-net-net-link" {
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-blob-core-windows-net.name
  name                  = azurerm_virtual_network.vnet.name
  resource_group_name   = azurerm_resource_group.dns-rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone" "privatelink-datafactory-azure-net" {
  name                = "privatelink.datafactory.azure.net"
  resource_group_name = azurerm_resource_group.dns-rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink-datafactory-azure-net-net-link" {
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-datafactory-azure-net.name
  name                  = azurerm_virtual_network.vnet.name
  resource_group_name   = azurerm_resource_group.dns-rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone" "privatelink-database-windows-net" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.dns-rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink-database-windows-net-net-link" {
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-database-windows-net.name
  name                  = azurerm_virtual_network.vnet.name
  resource_group_name   = azurerm_resource_group.dns-rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone" "privatelink-sql-azuresynapse-net" {
  name                = "privatelink.sql.azuresynapse.net"
  resource_group_name = azurerm_resource_group.dns-rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink-sql-azuresynapse-net-net-link" {
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-sql-azuresynapse-net.name
  name                  = azurerm_virtual_network.vnet.name
  resource_group_name   = azurerm_resource_group.dns-rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_private_dns_zone" "privatelink-vaultcore-azure-net" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.dns-rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink-vaultcore-azure-net-net-link" {
  private_dns_zone_name = azurerm_private_dns_zone.privatelink-vaultcore-azure-net.name
  name                  = azurerm_virtual_network.vnet.name
  resource_group_name   = azurerm_resource_group.dns-rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}
