publish_output "dev_vnet" {
  description = "Vnet"
  value       = deployment.dev.virtual_network_name
}
publish_output "dev_vnet_id" {
  description = "Vnet ID"
  value       = deployment.dev.virtual_network_id
}
publish_output "dev_subnet_app_id" {
  description = "Application Subnet ID"
  value       = deployment.dev.subnet_app_id
}
publish_output "dev_subnet_db_id" {
  description = "Database Subnet ID"
  value       = deployment.dev.subnet_db_id
}
