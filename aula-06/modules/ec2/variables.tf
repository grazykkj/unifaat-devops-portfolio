variable "instance_name" {
  description = "Nome da instância EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID da instância"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet onde a EC2 será criada"
  type        = string
}

variable "security_group_ids" {
  description = "Lista de IDs dos Security Groups"
  type        = list(string)
}

variable "key_name" {
  description = "Nome do Key Pair"
  type        = string
}

variable "user_data" {
  description = "Script opcional de inicialização"
  type        = string
  default     = null
}

variable "environment" {
  description = "Ambiente"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
}
