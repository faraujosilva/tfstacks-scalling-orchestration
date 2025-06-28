deployment "dev" {
  inputs = {
    ambiente = "dev"
    centro_de_custo = "dev-centro-custo"
    nome_aplicacao = "myapp-dev"
    cloud_provider = "azure"
    azure_region = "brazilsouth"
    address_space = ["10.0.0.0/16"]
    app_subnet = ["10.0.1.0/22"]
    db_subnet = ["10.0.4.0/22"]
  }
}

orchestrate "auto_approve" "safe_plans_dev" {
  check {
      # Only auto-approve in the development environment if no resources are being removed
      condition = context.plan.changes.remove == 0 && context.plan.deployment == deployment.dev
      reason = "Plan has ${context.plan.changes.remove} resources to be removed."
  }
}