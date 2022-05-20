terraform {
  required_providers{
      azurerm={
          source="hashicorp/azurerm"
          version = "=3.0.0"
      }
  }
}


provider "azurerm" {
    
    tenant_id = "e59c84a4-af3c-4b74-8a18-02eee8993bfb"
    subscription_id = "f84608ab-d9ac-4a5a-98b2-4c0438d0cf36"
    features {    
    }
}