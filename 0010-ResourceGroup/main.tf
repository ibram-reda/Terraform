terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.23.0"
    }
  }
}
locals {
  tags = {
      environment = "Lab"
      owner = "ibram"
  }
}

provider "azurerm" {
  features {}
}




resource "azurerm_resource_group" "resourcegroup" {
  name     = var.rsgname
  location = var.location
  tags = locals.tags
}

resource "azurerm_storage_account" "example" {
  name                     = var.stgactname
  resource_group_name      = azurerm_resource_group.resourcegroup.name
  location                 = azurerm_resource_group.resourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = locals.tags
}