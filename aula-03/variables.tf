variable "aws_region" {
  description = "Regiao AWS onde os recursos serao gerenciados."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto usado na identificacao dos recursos."
  type        = string
  default     = "technova"
}

variable "environment" {
  description = "Ambiente da infraestrutura."
  type        = string
  default     = "dev"
}

variable "aluno" {
  description = "Nome da aluna responsavel pela atividade."
  type        = string
  default     = "Grazielli Monteiro de Lima"
}

variable "ra" {
  description = "Registro academico, usado como prefixo dos nomes IAM."
  type        = string
  default     = "6325165"
}

locals {
  name_prefix = "${var.ra}-${var.project_name}"

  common_tags = {
    Project     = "TechNova"
    ManagedBy   = "Terraform"
    Aluno       = var.aluno
    RA          = var.ra
    Disciplina  = "DevOps - UniFAAT 2026-2"
    Aula        = "03"
    Environment = var.environment
  }
}
