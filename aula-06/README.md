# Aula 06 — Terraform Modules

## Visão geral

Biblioteca de módulos Terraform reutilizáveis para provisionar ambientes da TechNova.

A solução utiliza os mesmos módulos para criar os ambientes `dev` e `staging`, alterando apenas suas variáveis.

## Arquitetura

```text
                    ┌──────────────┐
                    │     VPC      │
                    │   módulo     │
                    └──────┬───────┘
                           │
             ┌─────────────┼─────────────┐
             │             │             │
             ▼             ▼             ▼
        Security       EC2           RDS
         Group       módulo         módulo
             │             │             │
             └─────────────┴─────────────┘

Composição principal:

VPC fornece vpc_id para os Security Groups.

VPC fornece subnets públicas para a EC2.

VPC fornece subnets privadas para o RDS.

Security Groups fornecem seus IDs para EC2 e RDS.

Módulos
VPC
Cria a VPC, Internet Gateway, subnets públicas e privadas e Route Table pública.

Inputs:

vpc_cidr

project_name

environment

subnets

Outputs:

vpc_id

public_subnet_ids

private_subnet_ids

Utiliza for_each para criar as subnets dinamicamente.

Security Group
Módulo genérico para criação de Security Groups.

Inputs:

name

description

vpc_id

ingress_rules

environment

project_name

Outputs:

sg_id

sg_name

As regras de entrada são definidas através de uma lista de objetos e o egress permite tráfego de saída.

EC2
Cria uma instância EC2 configurável.

Inputs:

instance_name

instance_type

ami_id

subnet_id

security_group_ids

key_name

user_data

Outputs:

instance_id

public_ip

private_ip

RDS
Cria um PostgreSQL utilizando subnets privadas e Security Group próprio.

Inputs:

db_name

db_username

db_password

subnet_ids

security_group_ids

instance_class

environment

project_name

Outputs:

db_endpoint

db_name

db_port

Ambientes
Dev
VPC: 10.0.0.0/16

Subnets públicas: 10.0.1.0/24, 10.0.2.0/24

Subnets privadas: 10.0.3.0/24, 10.0.4.0/24

EC2: t2.micro

RDS: db.t3.micro

Database: technova_dev

Staging
VPC: 10.1.0.0/16

Subnets públicas: 10.1.1.0/24, 10.1.2.0/24

Subnets privadas: 10.1.3.0/24, 10.1.4.0/24

EC2: t2.micro

RDS: db.t3.micro

Database: technova_staging

Como validar
cd environments/dev
terraform init
terraform validate
terraform plan

cd ../staging
terraform init
terraform validate
terraform plan

Os dois ambientes foram validados com terraform validate e o terraform plan apresentou:

Plan: 19 to add, 0 to change, 0 to destroy.

Pré-requisitos
Terraform instalado

AWS CLI configurado

Acesso ao AWS Academy Learner Lab

Key Pair disponível na região utilizada

Permissões necessárias para executar Terraform na conta AWS

Observação
Este projeto foi desenvolvido para o exercício da Aula 06 de Terraform Modules, utilizando módulos locais reutilizáveis para VPC, Security Group, EC2 e RDS.