terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.23.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}


resource "azurerm_resource_group" "Vnet_rg" {
  name = var.resourcegroup_name
  location = var.location
  tags = var.tags
}

resource "azurerm_virtual_network" "Vnet" {
    name = var.vnet_name
    address_space = var.vnet_address_space
    location = azurerm_resource_group.Vnet_rg.location
    resource_group_name = azurerm_resource_group.Vnet_rg.name
    tags = var.tags  
}



resource "azurerm_subnet" "subnet" {
  for_each = var.subnets
  resource_group_name = azurerm_resource_group.Vnet_rg.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  name = each.value["name"]
  address_prefixes = each.value["address_prefixes"]
}


resource "azurerm_public_ip" "bastion_pubip" {
  name = "${var.bastionhost_name}pubip"
  location = azurerm_resource_group.Vnet_rg.location
  resource_group_name = azurerm_resource_group.Vnet_rg.name
  allocation_method = "Static"
  sku = "Standard"
  tags = var.tags
}



resource "azurerm_bastion_host" "bastion" {
  name                = var.bastionhost_name
  location            = azurerm_resource_group.Vnet_rg.location
  resource_group_name = azurerm_resource_group.Vnet_rg.name
  tags                = var.tags

  ip_configuration {
    name                 = "bastion_config"
    subnet_id            = azurerm_subnet.subnet["bastion_subnet"].id
    public_ip_address_id = azurerm_public_ip.bastion_pubip.id
  }
}