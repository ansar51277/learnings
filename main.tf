resource "random_string" "stg" {
    length = 8
    override_special = "/@£$- .%&["
    lower = true
    upper = false
    special = false
    number = false 
}

resource "azurerm_resource_group" "rg" {
    name = "${random_string.stg.result}"
    location = "East US"
    tags = {
      "env" = "dev"
    }
  
}

resource "azurerm_virtual_network" "vnet" {
    for_each = var.v1
    resource_group_name = azurerm_resource_group.rg.name
    location = each.value["location"]
    name = each.value["name"]
    address_space = each.value["address_space"]  
}

resource "azurerm_subnet" "subnet" {
    resource_group_name = azurerm_resource_group.rg.name
    for_each = var.subnet
    name = each.value["name_subnet"]
    virtual_network_name = each.value["vnet_name"]
    address_prefixes = each.value["address_prefixes"]
      
}