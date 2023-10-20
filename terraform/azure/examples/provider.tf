terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>1.5.0"
    }
  }
}

provider "azurerm" {
  features {}

  client_id                  = " "
  client_secret              = " "
  tenant_id                  = " "
  subscription_id            = " "
  skip_provider_registration = true
}