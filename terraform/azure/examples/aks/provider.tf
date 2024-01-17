terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  required_version = ">=1.5.0"
}

provider "azurerm" {
  features {}

  client_id       = "54ae5591-08bf-4ca7-b546-afbd5fc2981c"
  client_secret   = ".h28Q~ahW2DXKY2PlN7fjM.988UtwYYC9B8k6cLD"
  tenant_id       = "9ca00460-1bd3-4c37-bdbb-432341e03634"
  subscription_id = "7b133aa5-f11a-44e8-bf3f-d5e227b3fb3b"

}
