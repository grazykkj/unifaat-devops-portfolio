module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
  environment  = var.environment
  subnets      = var.subnets
}

module "api_sg" {
  source = "../../modules/security-group"

  name         = "${var.project_name}-${var.environment}-api-sg"
  description  = "Security Group da API"
  vpc_id       = module.vpc.vpc_id
  environment  = var.environment
  project_name = var.project_name

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    }
  ]
}

module "rds_sg" {
  source = "../../modules/security-group"

  name         = "${var.project_name}-${var.environment}-rds-sg"
  description  = "Security Group do RDS"
  vpc_id       = module.vpc.vpc_id
  environment  = var.environment
  project_name = var.project_name

  ingress_rules = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
      description = "PostgreSQL"
    }
  ]
}

module "api_server" {
  source = "../../modules/ec2"

  instance_name      = "${var.project_name}-${var.environment}-api"
  instance_type      = "t2.micro"
  ami_id             = var.ami_id
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.api_sg.sg_id]
  key_name           = var.key_name
  environment        = var.environment
  project_name       = var.project_name
}

module "database" {
  source = "../../modules/rds"

  db_name            = "technova_dev"
  db_username        = var.db_username
  db_password        = var.db_password
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.rds_sg.sg_id]
  instance_class     = "db.t3.micro"
  environment        = var.environment
  project_name       = var.project_name
}
