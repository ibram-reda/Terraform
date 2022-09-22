 terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.23.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "ResourceGroup" {
  source = "./ResourceGroup"
  base_name = "TerraformExample01"
  location = "West US"
}

module "storageAcouunt" {
    source = "./StorageAccount"
    base_name = "TerraformExample01"
    sesource_group_name = module.ResourceGroup.rg_name_out
    location = "West US"
}