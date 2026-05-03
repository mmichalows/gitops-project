# 1. Konfiguracja OIDC dla GitHuba
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["1b511abead59c6ce207077c0bf0e0043b1382612"] # Standardowy "odcisk palca" certyfikatu GitHuba
}

# 2. Rola IAM, którą GitHub będzie "zakładał" na czas trwania pipeline'u
resource "aws_iam_role" "github_actions_role" {
  name = "GitHubActionsGitOpsRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Condition = {
          StringLike = {
            # TUTAJ ZMIEŃ "TWOJ_NICK_GITHUB" na swój login z GitHuba!
            "token.actions.githubusercontent.com:sub": "repo:mmichalows/gitops-project:*"
          }
          StringEquals = {
            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

# 3. Zwrócenie ARN roli w konsoli
output "github_actions_role_arn" {
  value       = aws_iam_role.github_actions_role.arn
  description = "Skopiuj to później do GitHub Actions"
}
