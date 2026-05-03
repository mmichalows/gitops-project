terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "gitops-state-ramzes-2026"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

# --- NASZE NOWE MODUŁY ---

module "github_iam" {
  source = "./modules/iam"
}

output "github_actions_role_arn" {
  value = module.github_iam.github_actions_role_arn
}

module "compute" {
  source = "./modules/compute"
  server_name = var.env_server_name
  bundle_id   = var.env_bundle_id
}


moved {
  from = aws_iam_openid_connect_provider.github
  to   = module.github_iam.aws_iam_openid_connect_provider.github
}

moved {
  from = aws_iam_role.github_actions_role
  to   = module.github_iam.aws_iam_role.github_actions_role
}
