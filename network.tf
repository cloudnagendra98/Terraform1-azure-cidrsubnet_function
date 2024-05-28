resource "azurerm_virtual_network" "ntier_vnet" {
  name                = "azure_ntier_vnet"
  resource_group_name = azurerm_resource_group.ntier_resg.name
  address_space       = [var.azure_ntier_cidr]
  location            = azurerm_resource_group.ntier_resg.location

  depends_on = [
    azurerm_resource_group.ntier_resg
  ]
}

resource "azurerm_subnet" "subnets" {
  #count                = 3
  #count = length(var.subnet_address_prefixes)
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.ntier_resg.name
  virtual_network_name = azurerm_virtual_network.ntier_vnet.name
  address_prefixes = [cidrsubnet(var.azure_ntier_cidr, 8, count.index)]
  #address_prefixes     = [format(var.subnet_address_prefixes, count.index)]
  #address_prefixes = [var.subnet_address_prefixes[count.index]]

  depends_on = [
    azurerm_resource_group.ntier_resg,
    azurerm_virtual_network.ntier_vnet
  ]

}