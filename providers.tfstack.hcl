required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.0"
  }

  azurerm = {
    source  = "hashicorp/azurerm"
    version = "~> 4.0"
  }

}

provider "aws" "this" {
  for_each = toset(var.aws_regions)

  config {
    region = each.value
  }
}

provider "azurerm" "this" {
  config {
    features {
      
    }
  }
}
