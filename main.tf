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
    timeouts {
      create = "90s"
    }
    
}

resource "azurerm_subnet" "subnet" {
    resource_group_name = azurerm_resource_group.rg.name
    for_each = var.subnet
    name = each.value["name_subnet"]
    virtual_network_name = each.value["vnet_name"]
    address_prefixes = each.value["address_prefixes"]
    depends_on = [azurerm_virtual_network.vnet]
    timeouts {
      create = "90s"
    }
     
}

resource "azurerm_network_security_group" "NSG" {
    for_each = var.subnet
    resource_group_name = azurerm_resource_group.rg.name
    name = "NSG"
    location = each.value["location"]
    depends_on = [
      azurerm_subnet.subnet
    ]
    timeouts {
      create = "120s"
    }

    }
resource "azurerm_network_security_rule" "rule" {
    for_each = var.subnet
    name = "nsg"
    priority = 100
    protocol = "Tcp"
    access = "Allow"
    direction = "Inbound"
    source_port_range          = "*"
    destination_port_range      = "3389"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name = azurerm_resource_group.rg.name
    network_security_group_name = "nsg"
    depends_on = [
      azurerm_network_security_group.NSG
    ]
    
    }

  

resource "azurerm_subnet_network_security_group_association" "associate" {
    for_each = var.subnet
    subnet_id = azurerm_subnet.subnet[each.value].address_prefixes
    network_security_group_id = azurerm_resource_group.rg.id
  }


