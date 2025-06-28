variable "ambiente" {
    description = "Ambiente para provisionamento da stack"
    type        = string
    default     = "dev"
}

variable "centro_de_custo" {
    description = "Centro de custo para provisionamento da stack"
    type        = string
}

variable "nome_aplicacao" {
    description = "Nome da aplicação para provisionamento da stack"
    type        = string
}

variable "cloud_provider" {
    description = "Cloud provider para provisionamento da stack"
    type        = string
}

variable "aws_regions" {
    description = "Regiões da AWS para provisionamento da stack"
    type        = list(string)
    default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "azure_region" {
    description = "Regiões do Azure para provisionamento da stack"
    type        = string
    default = "brazilsouth"
}

variable "address_space" {
    description = "Espaço de endereços para a rede virtual"
    type        = list(string)
}

variable "app_subnet" {
    description = "Prefixo de endereço para a sub-rede de aplicação"
    type        = list(string)
}

variable "db_subnet" {
    description = "Prefixo de endereço para a sub-rede de banco de dados"
    type        = list(string)
}