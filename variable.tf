variable "v1" {
  description = "These are Ip address and names of Vnet"
  type = map(any)
  default =  {

      vnet1 ={

          location = "East Us"
          name = "vnet1"
          address_space = ["10.10.0.0/16"]
          vnetname = "vnet1"
      }

      vnet2={
          location = "South India"
          name = "vnet2"
          address_space = ["10.100.0.0/16"]
          vnetname = "vnet2"
      }
  }
}

  variable "subnet" {
  type =map(any)
  description = "These are subnet configurations"
  default = {
   
      subnet-1={
          name_subnet = "subnet1"
          address_prefixes = ["10.10.10.0/24"]
          vnet_name = "vnet1"
           }

          subnet-2={
          name_subnet = "subnet2"
          address_prefixes = ["10.100.100.0/24"]
          vnet_name = "vnet2"
             }

        subnet-3={
          name_subnet = "subnet1appgateway"
          address_prefixes = ["10.10.101.0/24"]
          vnet_name = "vnet1"

        }

        subnet-4 = {
            name_subnet = "subnet2appgateway"
          address_prefixes = ["10.100.11.0/24"]
          vnet_name = "vnet2"

        }

  }
  }

variable "nsg" {
    description = "This is created to define NSG rules"
    type = map(any)
    default = {

      "NSG_Rule1" = {
          name = "NSG1"
          subnet_name = "subnet1"
          address_prefixes = ["10.10.10.0/24"]
          location = "East Us"
      }

      "NSG_Rule2" = {
          name = "NSG2"
           subnet_name = "subnet1"
          address_prefixes = ["10.10.10.0/24"]
          location = "South India"

      }

    }
  
}
