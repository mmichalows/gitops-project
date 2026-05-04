terraform {
  backend "s3" {
    bucket       = "gitops-state-ramzes-2026"
    key          = "global/s3/terraform.tfstate"
    region       = "eu-central-1"
    use_lockfile = true  # NOWOŚĆ: Natywne blokowanie stanu (zastąpiło dynamodb_table)
  }
}

provider "aws" {
  region = "eu-central-1"
}

# -----------------------------------------------------------
# 1. MODUŁ IAM (Uprawnienia dla GitHuba)
# -----------------------------------------------------------
module "iam" {
  source = "./modules/iam"
}

output "github_actions_role_arn" {
  description = "ARN roli dla GitHub Actions (OIDC)"
  value       = module.iam.github_actions_role_arn 
  # Upewnij się, że odwołujesz się do poprawnej nazwy outputu ze swojego modułu
}

# -----------------------------------------------------------
# 2. TWÓJ SERWER LIGHTSAIL (Aplikacja)
# -----------------------------------------------------------
# Tutaj znajduje się Twój dotychczasowy kod powołujący serwer n8n01.
# Może to być moduł (np. module "compute" { ... }) 
# lub bezpośredni zasób (resource "aws_lightsail_instance" ...).
# Zostaw tę część dokładnie tak, jak miałeś ją zanim zaczęliśmy bawić się bazą!


# UWAGA: Moduł bazy danych (module "database") oraz jej output (database_address) 
# zostały stąd całkowicie USUNIĘTE, zgodnie z naszą procedurą czyszczenia chmury!
