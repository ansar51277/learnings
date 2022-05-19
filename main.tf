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
    #timeouts {
     # create = "90s"
    #}
    
}

resource "azurerm_subnet" "subnet" {
    resource_group_name = azurerm_resource_group.rg.name
    for_each = var.subnet
    name = each.value["name_subnet"]
    virtual_network_name = each.value["vnet_name"]
    address_prefixes = each.value["address_prefixes"]
    #depends_on = [azurerm_virtual_network.vnet]
     
}

resource "azurerm_network_security_group" "NSG" {
    resource_group_name = azurerm_resource_group.rg.name
    for_each = var.nsg
    name = each.value["name"]
    location = each.value["location"]
    #id = azurerm_network_security_group.NSG.id

    }
resource "azurerm_network_security_rule" "rule" {
    for_each = var.nsg
    name = each.value["name"]
    priority = 100
    protocol = "Tcp"
    access = "Allow"
    direction = "Inbound"
    source_port_range           = "*"
    destination_port_range      = "3389"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name = azurerm_resource_group.rg.name
    network_security_group_name = each.value["name"]
    
}

resource "azurerm_subnet_network_security_group_association" "nsgasscociate" {
    for_each = var.nsg
    subnet_id = each.value["address_prefixes"]
    network_security_group_id = each.value["id"]
  }