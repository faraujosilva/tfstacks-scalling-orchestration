
variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
}

variable "location" {
  description = "The Azure region where the virtual network will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual network will be created."
  type        = string
}

variable "ambiente" {
  description = "The environment for which the virtual network is being created (e.g., dev, prod)."
  type        = string
}

variable "app_subnet" {
  description = "The address prefix for the application subnet."
  type        = list(string)
}

variable "db_subnet" {
  description = "The address prefix for the database subnet."
  type        = list(string)
}

resource "azurerm_virtual_network" "this" {
  name = var.virtual_network_name
  address_space = var.address_space
  location = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "app" {
  name                 = "subnet-${var.ambiente}-app"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  # FIrst subnet for application services
  address_prefixes     =  var.app_subnet
}

resource "azurerm_subnet" "db" {
  name                 = "subnet-${var.ambiente}-db"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     =  var.db_subnet
}


output "id" {
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.his.id
}

output "name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.his.name
}

output "address_space" {
  description = "The address space of the virtual network."
  value       = azurerm_virtual_network.his.address_space
}

output "subnet_app_id" {
  description = "The ID of the application subnet."
  value       = azurerm_subnet.app.id
}

output "subnet_db_id" {
  description = "The ID of the database subnet."
  value       = azurerm_subnet.db.id
}

output "subnet_app_name" {
  description = "The name of the application subnet."
  value       = azurerm_subnet.app.name
}

output "subnet_db_name" {
  description = "The name of the database subnet."
  value       = azurerm_subnet.db.name
}