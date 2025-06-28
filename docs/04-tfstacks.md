# TF Stacks na Prática

## Componentes e Abstração

### Estrutura Base
```hcl
# components.tfstack.hcl
component "base_network" {
  source = "./modules/vnet"
  version = "1.0.0"
  
  inputs = {
    resource_group_name = component.rg.name
    location = "eastus2"
    address_space = ["10.0.0.0/16"]
  }
}

component "rg" {
  source = "./modules/rg"
  version = "1.0.0"
  
  inputs = {
    name = "demo-rg"
    location = "eastus2"
  }
}
```

### Composição de Componentes

#### Hierarquia de Recursos
- Componentes base (resource groups, networking)
- Componentes de plataforma (databases, caches)
- Componentes de aplicação (compute, storage)

#### Reutilização
```hcl
# Componente reutilizável para ambientes
component "environment" {
  for_each = var.environments

  source = "./modules/environment"
  version = "1.0.0"
  
  inputs = {
    name = each.key
    settings = each.value
  }
}
```

## Multi-cloud Capabilities

### Abstração Cloud-Agnostic
```hcl
# providers.tfstack.hcl
provider "cloud" {
  type = var.cloud_provider # "aws" ou "azure" ou "gcp"
  
  config = {
    region = var.region
  }
}

component "storage" {
  source = "./modules/${var.cloud_provider}/storage"
  version = "1.0.0"
  
  inputs = {
    size = "100GB"
    type = "standard"
  }
}
```

### Estratégias Multi-cloud

#### Deploy Paralelo
```hcl
# deployments.tfdeploy.hcl
deployment "multi_region" {
  component "primary" {
    provider = "aws"
    region = "us-east-1"
  }
  
  component "secondary" {
    provider = "azure"
    region = "eastus2"
  }
}
```

#### Failover Automático
```hcl
orchestrate "failover" {
  watch "primary_health" {
    component = component.primary
    
    condition = health_check(component.primary) == "healthy"
    
    on_failure = {
      activate = component.secondary
    }
  }
}
```

## Gestão de Ambientes

### Definição de Ambientes
```hcl
# variables.tfstack.hcl
variable "environments" {
  type = map(object({
    size = string
    replicas = number
    monitoring = bool
  }))
  
  default = {
    dev = {
      size = "small"
      replicas = 1
      monitoring = false
    }
    prod = {
      size = "large"
      replicas = 3
      monitoring = true
    }
  }
}
```

### Políticas por Ambiente
```hcl
policy "environment_rules" {
  for_each = var.environments
  
  assert {
    condition = each.value.monitoring == true if each.key == "prod"
    error_message = "Monitoring must be enabled in production"
  }
}
```

## Validação e Testes

### Testes de Componentes
```hcl
test "storage_component" {
  component "test_storage" {
    source = "./modules/storage"
    
    mock_inputs = {
      size = "10GB"
    }
    
    assert {
      condition = component.test_storage.provisioned
      error_message = "Storage failed to provision"
    }
  }
}
```

### Validações de Segurança
```hcl
validate "security" {
  assert {
    condition = all(component.*.encrypted == true)
    error_message = "All components must use encryption"
  }
  
  assert {
    condition = !contains(component.*.public_access, true)
    error_message = "No public access allowed"
  }
}
```

## Monitoramento e Logging

### Métricas de Componentes
```hcl
monitor "component_health" {
  for_each = component.*
  
  metric "status" {
    query = "health_status"
    threshold = "healthy"
    
    alert {
      severity = "critical"
      message = "Component ${each.key} is unhealthy"
    }
  }
}
```

### Auditoria
```hcl
audit "changes" {
  log_level = "INFO"
  
  track {
    resources = ["*"]
    actions = ["create", "update", "delete"]
  }
}
```

## Melhores Práticas

### Organização de Código
- Estrutura de diretórios clara
- Separação de concerns
- Documentação inline
- Convenções de nomenclatura

### Performance
- Paralelização de deployments
- Cache de estados
- Otimização de dependências
- Lazy loading de componentes

### Segurança
- Least privilege access
- Secrets management
- Auditoria completa
- Validações automáticas

### Operacional
- Backups automáticos
- Disaster recovery
- Monitoramento proativo
- Escalabilidade horizontal