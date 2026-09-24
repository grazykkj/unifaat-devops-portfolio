variable "aws_region" {
  description = "Região AWS"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "environment" {
  description = "Ambiente"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
}

variable "subnets" {
  description = "Mapa de subnets"
  type = map(object({
    cidr = string
    az   = string
    type = string
  }))
}

variable "ami_id" {
  description = "AMI ID para a EC2"
  type        = string
}

variable "key_name" {
  description = "Nome do Key Pair"
  type        = string
}

variable "db_username" {
  description = "Usuário do RDS"
  type        = string
}

variable "db_password" {
  description = "Senha do RDS"
  type        = string
  sensitive   = true
}
