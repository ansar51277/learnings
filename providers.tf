terraform {
  required_providers{
      azurerm={
          source="hashicorp/azurerm"
          version = "=3.0.0"
      }
  }
}


provider "azurerm" {
    
    tenant_id = "63ce7d59-2f3e-42cd-a8cc-be764cff5eb6"
    subscription_id = "ec1f270c-19ab-4efb-b880-5ed7490b39bb"
    features {    
    }
}