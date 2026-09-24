output "vpc_id" {
  description = "ID da VPC"
  value       = module.vpc.vpc_id
}

output "api_security_group_id" {
  description = "ID do Security Group da API"
  value       = module.api_sg.sg_id
}

output "rds_security_group_id" {
  description = "ID do Security Group do RDS"
  value       = module.rds_sg.sg_id
}

output "instance_id" {
  description = "ID da instância EC2"
  value       = module.api_server.instance_id
}

output "public_ip" {
  description = "IP público da EC2"
  value       = module.api_server.public_ip
}

output "db_endpoint" {
  description = "Endpoint do RDS"
  value       = module.database.db_endpoint
}

output "db_name" {
  description = "Nome do database"
  value       = module.database.db_name
}

output "db_port" {
  description = "Porta do database"
  value       = module.database.db_port
}
