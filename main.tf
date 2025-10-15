terraform {
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      "source" = "hashicorp/azurerm"
      version  = "3.43.0"
    }
  }
  cloud {

    organization = "test-org12231"

    workspaces {
      name = "TerraformCI"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id            = "0cfe2870-d256-4119-b0a3-16293ac11bdc"
  skip_provider_registration = true
}

resource "random_string" "uniquestring" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "811-3f97f501-provide-continuous-delivery-with-gith"
  location = "southcentralus"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "stg${random_string.uniquestring.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
