variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
} 

variable "location" {
  description = "The Azure region where the resource group will be created."
  type        = string
}



resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location

}

output "id" {
  description = "The ID of the resource group."
  value       = azurerm_resource_group.this.id
}

output "name" {
  description = "The name of the resource group."
  value       = azurerm_resource_group.this.name
}