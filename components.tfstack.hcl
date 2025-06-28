locals {
  address_octect = var.ambiente == "dev" ? "1" : "2"
}

component "resource_group" {
  source  = "./rg"
  inputs = {
    location = var.azure_region
    resource_group_name = "${var.nome_aplicacao}-${var.ambiente}-rg"
  }
  
  providers = {
    azurerm = provider.azurerm.this
  }
}

component "virtual_network" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.9.1"
  inputs = {
    address_space = ["10.${local.address_octect}.0.0/16"]
    location = var.azure_region
    resource_group_name = component.resource_group.outputs.name
  }
  providers = {
    azurerm = provider.azurerm.this
  }
}