required_providers {
  aws = {
    source  = "hashicorp/aws"
  }

  azurerm = {
    source  = "hashicorp/azurerm"
  }

}

provider "aws" "this" {
  for_each = var.aws_regions
}

provider "azurerm" "this" {
    features {}
}
