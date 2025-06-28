store "varset" "tokens" {
  id       = "varset-Bh4fQ4Vxk5CX8r9v"
  category = "env"
}

deployment "dev" {
  inputs = {
    ambiente = "dev"
    centro_de_custo = "dev-centro-custo"
    nome_aplicacao = "myapp-dev"
    cloud_provider = "azure"
    azure_region = "brazilsouth"
    address_space = ["10.0.0.0/16"]
    app_subnet = ["10.0.0.0/22"]
    db_subnet = ["10.0.4.0/22"]
    client_id = store.varset.tokens.ARM_CLIENT_ID
    client_secret = store.varset.tokens.ARM_CLIENT_SECRET
    subscription_id = "84c846a7-3273-4925-be8c-a43f407fa842" 
    tenant_id = store.varset.tokens.ARM_TENANT_ID 
  }
}


deployment "prd" {
  inputs = {
    ambiente = "prd"
    centro_de_custo = "prd-centro-custo"
    nome_aplicacao = "myapp-prd"
    cloud_provider = "azure"
    azure_region = "brazilsouth"
    address_space = ["10.1.0.0/16"]
    app_subnet = ["10.1.0.0/22"]
    db_subnet = ["10.1.4.0/22"]
    client_id = store.varset.tokens.ARM_CLIENT_ID
    client_secret = store.varset.tokens.ARM_CLIENT_SECRET
    subscription_id = "a5200402-7c6f-495f-bdb2-ab0afe6917f1"  
    tenant_id = store.varset.tokens.ARM_TENANT_ID 
  }
}
orchestrate "auto_approve" "safe_plans_dev" {
  check {
      # Only auto-approve in the development environment if no resources are being removed
      condition = context.plan.changes.remove == 0 && context.plan.deployment == deployment.dev
      reason = "Plan has ${context.plan.changes.remove} resources to be removed."
  }
}

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

publish_output "prd_vnet" {
  description = "Vnet"
  value       = deployment.prd.virtual_network_name
}
publish_output "prd_vnet_id" {
  description = "Vnet ID"
  value       = deployment.prd.virtual_network_id
}
publish_output "prd_subnet_app_id" {
  description = "Application Subnet ID"
  value       = deployment.prd.subnet_app_id
}
publish_output "prd_subnet_db_id" {
  description = "Database Subnet ID"
  value       = deployment.prd.subnet_db_id
}
