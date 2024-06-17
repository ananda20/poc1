resource "azurerm_resource_group" "poc-network-ne" {
  name     = "poc-netwowrkrg-ne"
  location = "North Europe"
}

resource "azurerm_network_security_group" "poc-network-security-grp-ne" {
  name                = "poc-netwowrksecurity-grp-ne"
  location            = azurerm_resource_group.poc-network-ne.location
  resource_group_name = azurerm_resource_group.poc-network-ne.name
}

resource "azurerm_virtual_network" "poc-vnet" {
  name                = "poc-vnet-ne"
  location            = azurerm_resource_group.poc-network-ne.location
  resource_group_name = azurerm_resource_group.poc-network-ne.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.poc-network-security-grp-ne.id
  }

  tags = {
    environment = "Production"
  }
}