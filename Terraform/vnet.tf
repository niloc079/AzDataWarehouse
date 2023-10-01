#
#Resource Group
resource "azurerm_resource_group" "vnet-rg" {
    name                    = "${var.environment}vnet-rg"
    location                = var.location
}

#VNET
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.vnet-rg.name
  address_space       = var.vnet_address_space
  #dns_servers         = []
  tags                = var.tags
}

resource "azurerm_subnet" "vnet-subnet-1" {
  name                 = "${local.environment}-vnet-pvl"
  resource_group_name  = azurerm_resource_group.vnet-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.vnet_address_space_sub_pvl
  private_link_service_network_policies_enabled = false
}