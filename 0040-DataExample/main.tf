terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.23.0"
    }
  }
}

provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion     = true
      skip_shutdown_and_force_delete = true
    }
  }
}


resource "azurerm_resource_group" "resourcegroup" {
    name     = "TFTestRG01"
  location = "west us 3"
}

data "azurerm_subnet" "vmsubnet" {
  name                 = var.subname
  virtual_network_name = var.vnetname
  resource_group_name  = var.vnetrg
}


module "vm" {
  source     = "./winServer"
  rgname     = azurerm_resource_group.resourcegroup.name
  location   = azurerm_resource_group.resourcegroup.location
  vmname     = "TFTestServer"
  size       = "Standard_B1s"
  localadmin = "localadmin"
  adminpw    = var.adminpw
  subnetid   = data.azurerm_subnet.vmsubnet.id
}