locals {
  address_octect = var.ambiente == "dev" ? "1" : "2"
}

component "resource_group" {
  source  = "./modules/rg"
  inputs = {
    location = var.azure_region
    resource_group_name = "${var.nome_aplicacao}-${var.ambiente}-rg"
  }
  
  providers = {
    azurerm = provider.azurerm.this
  }

}

component "virtual_network" {
  source  = "./modules/vnet"
  inputs = {
    ambiente = var.ambiente
    virtual_network_name = "vnet-${var.ambiente}"
    address_space = var.address_space
    location = var.azure_region
    resource_group_name = component.resource_group.name
    app_subnet = var.app_subnet
    db_subnet = var.db_subnet
  }
  providers = {
    azurerm = provider.azurerm.this
  }
}