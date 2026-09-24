aws_region   = "us-east-1"
project_name = "technova"
environment  = "staging"

vpc_cidr = "10.1.0.0/16"

subnets = {
  public-1 = {
    cidr = "10.1.1.0/24"
    az   = "us-east-1a"
    type = "public"
  }

  public-2 = {
    cidr = "10.1.2.0/24"
    az   = "us-east-1b"
    type = "public"
  }

  private-1 = {
    cidr = "10.1.3.0/24"
    az   = "us-east-1a"
    type = "private"
  }

  private-2 = {
    cidr = "10.1.4.0/24"
    az   = "us-east-1b"
    type = "private"
  }
}

ami_id      = "ami-0fef201115eefe936"
key_name    = "vockey"
db_username = "technova"
db_password = "TechnovaStaging123"
